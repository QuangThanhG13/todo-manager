package com.qthanh.todo.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.springframework.stereotype.Service;

import com.qthanh.model.Todo;

@Service
public class TodoService {
    private static List<Todo> todos = new ArrayList<Todo>();
    private static int todoCount = 3;

    static {
        todos.add(new Todo(1, "in28Minutes", "Learn Spring MVC", new Date(),
                false));
        todos.add(new Todo(2, "in28Minutes", "Learn Struts", new Date(), false));
        todos.add(new Todo(3, "in28Minutes", "Learn Hibernate", new Date(),
                false));
    }

//    public List<Todo> retrieveTodos(String user) {
//        List<Todo> filteredTodos = new ArrayList<Todo>();
//        for (Todo todo : todos) {
//            if (todo.getUser().equals(user))
//                filteredTodos.add(todo);
//        }
//        return filteredTodos;
//    }


    // In com.in28minutes.todo.service.TodoService class
   // Find this method and modify it:
    public List<Todo> retrieveTodos(String user) {
        List<Todo> filteredTodos = new ArrayList<Todo>();
        for (Todo todo : todos) {
            // Fix the null pointer by adding a null check before comparing
            if (todo.getUser() != null && todo.getUser().equals(user)) {
                filteredTodos.add(todo);
            }
        }
        return filteredTodos;
    }

    public Todo retrieveTodo(int id) {
        for (Todo todo : todos) {
            if (todo.getId() == id)
                return todo;
        }
        return null;
    }

//    public void updateTodo(Todo todo) {
//        todos.remove(todo);
//        todos.add(todo);
//    }
public void updateTodo(Todo updatedTodo) {
    for (int i = 0; i < todos.size(); i++) {
        if (todos.get(i).getId() == updatedTodo.getId()) {
            todos.set(i, updatedTodo); // Cập nhật đúng vị trí trong danh sách
            return;
        }
    }
}


    public void addTodo(String name, String desc, Date targetDate, boolean isDone) {
        todos.add(new Todo(++todoCount, name, desc, targetDate, isDone));
    }

    public void deleteTodo(int id) {
        Iterator<Todo> iterator = todos.iterator();
        while (iterator.hasNext()) {
            Todo todo = iterator.next();
            if (todo.getId() == id) {
                iterator.remove();
            }
        }
    }
}