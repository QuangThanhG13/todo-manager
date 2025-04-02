package com.qthanh.todo.service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.qthanh.model.Todo;

@Service
public class TodoService {
    // Using ConcurrentHashMap for thread-safety and better performance with O(1) access
    private static final Map<Integer, Todo> todoMap = new ConcurrentHashMap<>();
    private static int todoCount = 3;

    static {
        todoMap.put(1, new Todo(1, "in28Minutes", "Learn Spring MVC", LocalDate.now().plusDays(10), false));
        todoMap.put(2, new Todo(2, "in28Minutes", "Learn Struts", LocalDate.now().plusDays(20), false));
        todoMap.put(3, new Todo(3, "in28Minutes", "Learn Hibernate", LocalDate.now().plusDays(30), false));
    }

    // Optimized to use stream filtering which is more efficient and cleaner
    public List<Todo> retrieveTodos(String user) {
        if (user == null) {
            return Collections.emptyList();
        }
        
        return todoMap.values().stream()
                .filter(todo -> user.equals(todo.getUser()))
                .collect(Collectors.toList());
    }

    // O(1) access by ID
    public Todo retrieveTodo(int id) {
        try {
            System.out.println("TodoService.retrieveTodo called with ID: " + id);
            
            if (id <= 0) {
                System.err.println("Error: Invalid Todo ID requested: " + id);
                return null;
            }
            
            Todo todo = todoMap.get(id);
            if (todo == null) {
                System.err.println("Warning: No Todo found with ID: " + id);
            } else {
                System.out.println("Successfully retrieved Todo: " + todo);
            }
            
            return todo;
        } catch (Exception e) {
            System.err.println("Error retrieving Todo with ID " + id + ": " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    // O(1) update operation
    public void updateTodo(Todo updatedTodo) {
        try {
            System.out.println("TodoService.updateTodo called with: " + updatedTodo);
            
            if (updatedTodo == null) {
                System.err.println("Error: Attempted to update null Todo object");
                return;
            }
            
            if (updatedTodo.getId() <= 0) {
                System.err.println("Error: Invalid Todo ID: " + updatedTodo.getId());
                return;
            }
            
            // Check if the Todo exists before updating
            Todo existingTodo = todoMap.get(updatedTodo.getId());
            if (existingTodo == null) {
                System.err.println("Error: Todo with ID " + updatedTodo.getId() + " does not exist");
                return;
            }
            
            // Update the todo
            todoMap.put(updatedTodo.getId(), updatedTodo);
            System.out.println("Successfully updated Todo: " + updatedTodo);
        } catch (Exception e) {
            System.err.println("Error updating Todo: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // Thread-safe add operation
    public void addTodo(String name, String desc, LocalDate targetDate) {
        int id;
        synchronized (TodoService.class) {
            id = ++todoCount;
        }
        // Use the provided target date or default to today if null
        LocalDate finalTargetDate = (targetDate != null) ? targetDate : LocalDate.now();
        todoMap.put(id, new Todo(id, name, desc, finalTargetDate, false));
    }

    // For backward compatibility
    public void addTodo(String name, String desc, java.util.Date targetDate, boolean isDone) {
        addTodo(name, desc, targetDate != null ? 
            LocalDate.ofInstant(targetDate.toInstant(), java.time.ZoneId.systemDefault()) : 
            LocalDate.now());
    }

    // O(1) delete operation
    public void deleteTodo(int id) {
        todoMap.remove(id);
    }
}