package com.qthanh.todo;

import com.qthanh.model.Todo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.qthanh.todo.service.TodoService;

import javax.validation.Valid;
import java.beans.PropertyEditorSupport;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller
@SessionAttributes({"name", "currentPage"})
public class TodoController {

    private static final int PAGE_SIZE = 10;
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("dd/MM/yyyy");

    @Autowired
    private TodoService service;

    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        // Add a custom editor for LocalDate
        binder.registerCustomEditor(LocalDate.class, new PropertyEditorSupport() {
            @Override
            public void setAsText(String text) throws IllegalArgumentException {
                if (text == null || text.trim().isEmpty()) {
                    setValue(null);
                } else {
                    setValue(LocalDate.parse(text, DATE_FORMATTER));
                }
            }

            @Override
            public String getAsText() {
                LocalDate value = (LocalDate) getValue();
                return (value != null ? value.format(DATE_FORMATTER) : "");
            }
        });
    }

    @RequestMapping(value = "/list-todos", method = RequestMethod.GET)
    public String showTodoList(ModelMap model, 
                             @RequestParam(defaultValue = "-1") int page) {
        // Get username from Spring Security context
        String user = null;
        
        // Get from Spring Security
        try {
            org.springframework.security.core.Authentication authentication = 
                org.springframework.security.core.context.SecurityContextHolder.getContext().getAuthentication();
                
            if (authentication != null && authentication.isAuthenticated()) {
                // Get the username based on principal type
                Object principal = authentication.getPrincipal();
                if (principal instanceof org.springframework.security.core.userdetails.UserDetails) {
                    user = ((org.springframework.security.core.userdetails.UserDetails) principal).getUsername();
                } else {
                    user = principal.toString();
                }
            }
        } catch (Exception e) {
            // Fallback to default user if any error occurs
            user = "User";
        }
        
        // Use user from authentication or default to session value
        if (user == null || user.isEmpty() || "anonymousUser".equals(user)) {
            // Fallback to session
            user = (String) model.get("name");
            if (user == null || user.isEmpty()) {
                user = "User";  // Default fallback
            }
        }
        
        // Store in model and session
        model.put("name", user);
        
        // Check if page parameter was provided
        Integer currentPage = (Integer) model.get("currentPage");
        if (page == -1 && currentPage != null) {
            // Use the saved page from session if no page parameter was explicitly provided
            page = currentPage;
        } else if (page != -1) {
            // Update the session with the new page
            model.put("currentPage", page);
        } else {
            // Default to page 0 if neither parameter nor session has page info
            page = 0;
            model.put("currentPage", page);
        }
        
        // Get all todos for user
        List<Todo> todos = service.retrieveTodos(user);
        
        // Simple pagination
        int totalItems = todos.size();
        int totalPages = (int) Math.ceil((double) totalItems / PAGE_SIZE);
        
        // Validate page
        page = Math.max(0, Math.min(page, totalPages - 1 < 0 ? 0 : totalPages - 1));
        model.put("currentPage", page); // Update in case it was adjusted
        
        int fromIndex = page * PAGE_SIZE;
        int toIndex = Math.min(fromIndex + PAGE_SIZE, totalItems);
        
        // Create paged subset
        List<Todo> pagedTodos = fromIndex < toIndex 
            ? todos.subList(fromIndex, toIndex) 
            : List.of();
            
        model.addAttribute("todos", pagedTodos);
        model.addAttribute("totalPages", totalPages);
        return "list-todos";
    }

    @RequestMapping(value = "/add-todo", method = RequestMethod.GET)
    public String showTodoPage(ModelMap model) {
        model.addAttribute("todo", new Todo());
        return "todo";
    }

    @RequestMapping(value = "/add-todo", method = RequestMethod.POST)
    public String addTodo(ModelMap model, @Valid Todo todo, BindingResult result) {
        if (result.hasErrors()) {
            return "todo";
        }
        service.addTodo((String) model.get("name"), todo.getDesc(), todo.getTargetDate());
        return "redirect:/list-todos";
    }

    @RequestMapping(value = "/update-todo", method = RequestMethod.GET)
    public String showUpdateTodo(ModelMap model, @RequestParam int id) {
        model.addAttribute("todo", service.retrieveTodo(id));
        return "todo";
    }

    @RequestMapping(value = "/update-todo", method = RequestMethod.POST)
    public String updateTodo(ModelMap model, @Valid Todo todo, BindingResult result) {
        if (result.hasErrors()) {
            return "todo";
        }
        
        todo.setUser((String) model.get("name"));
        service.updateTodo(todo);
        return "redirect:/list-todos";
    }

    @RequestMapping(value = "/delete-todo", method = RequestMethod.GET)
    public String deleteTodoPage(@RequestParam int id) {
        service.deleteTodo(id);
        return "redirect:/list-todos";
    }
    
    @RequestMapping(value = "/update-todo-status", method = RequestMethod.POST)
    public String updateTodoStatus(ModelMap model, 
                                  @RequestParam int id, 
                                  @RequestParam String completed) {
        try {
            System.out.println("=== START UPDATE TODO STATUS ===");
            System.out.println("Parameters - ID: " + id + ", Completed: " + completed);
            System.out.println("ModelMap contents: " + model);
            
            // Convert string parameter to boolean
            boolean isCompleted = Boolean.parseBoolean(completed);
            System.out.println("Parsed completed value: " + isCompleted);
            
            // Get current todo
            Todo todo = service.retrieveTodo(id);
            System.out.println("Retrieved Todo: " + (todo != null ? todo.toString() : "null"));
            
            if (todo != null) {
                // Update completion status
                System.out.println("Updating Todo - Before: " + todo);
                todo.setDone(isCompleted);
                service.updateTodo(todo);
                System.out.println("Updating Todo - After: " + todo);
            } else {
                System.out.println("Todo with id " + id + " not found");
            }
            
            // Get page parameter from session
            Integer currentPage = (Integer) model.get("currentPage");
            System.out.println("Current page from session: " + currentPage);
            if (currentPage == null) {
                currentPage = 0;
                System.out.println("Setting default page to 0");
            }
            
            String redirectUrl = "redirect:/list-todos?page=" + currentPage;
            System.out.println("Redirecting to: " + redirectUrl);
            System.out.println("=== END UPDATE TODO STATUS ===");
            
            // Redirect back to the same page of the list
            return redirectUrl;
        } catch (Exception e) {
            // Log any exceptions
            System.err.println("=== ERROR IN UPDATE TODO STATUS ===");
            System.err.println("Error type: " + e.getClass().getName());
            System.err.println("Error message: " + e.getMessage());
            System.err.println("Stack trace:");
            e.printStackTrace();
            System.err.println("=== END ERROR LOG ===");
            
            // Redirect to list-todos without parameters in case of error
            return "redirect:/list-todos";
        }
    }

    @RequestMapping(value = "/update-status", method = RequestMethod.GET)
    public String updateTodoStatusAlternative(@RequestParam int id, ModelMap model) {
        try {
            System.out.println("=== START ALTERNATIVE UPDATE TODO STATUS ===");
            System.out.println("Parameters - ID: " + id);
            
            // Get current todo
            Todo todo = service.retrieveTodo(id);
            System.out.println("Retrieved Todo: " + (todo != null ? todo.toString() : "null"));
            
            if (todo != null) {
                // Invert the status
                boolean newStatus = !todo.isDone();
                System.out.println("Inverting status from " + todo.isDone() + " to " + newStatus);
                
                // Update status
                System.out.println("Updating Todo - Before: " + todo);
                todo.setDone(newStatus);
                service.updateTodo(todo);
                System.out.println("Updating Todo - After: " + todo);
                
                // Prepare success message
                String statusMessage = newStatus ? "Todo marked as completed!" : "Todo marked as in progress!";
                String statusType = newStatus ? "success" : "info";
                
                model.addAttribute("statusMessage", statusMessage);
                model.addAttribute("statusType", statusType);
            } else {
                model.addAttribute("statusMessage", "Todo not found!");
                model.addAttribute("statusType", "error");
                System.out.println("Todo with id " + id + " not found");
            }
            
            // Get page parameter from session
            Integer currentPage = (Integer) model.get("currentPage");
            System.out.println("Current page from session: " + currentPage);
            if (currentPage == null) {
                currentPage = 0;
                System.out.println("Setting default page to 0");
            }
            
            System.out.println("=== END ALTERNATIVE UPDATE TODO STATUS ===");
            return "redirect:/list-todos?page=" + currentPage;
        } catch (Exception e) {
            // Log any exceptions
            System.err.println("=== ERROR IN ALTERNATIVE UPDATE TODO STATUS ===");
            System.err.println("Error type: " + e.getClass().getName());
            System.err.println("Error message: " + e.getMessage());
            System.err.println("Stack trace:");
            e.printStackTrace();
            
            // Add error message to model
            model.addAttribute("statusMessage", "Error updating todo: " + e.getMessage());
            model.addAttribute("statusType", "error");
            
            System.err.println("=== END ERROR LOG ===");
            return "redirect:/list-todos";
        }
    }
}