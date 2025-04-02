package com.qthanh.model;

import javax.validation.constraints.Size;
import java.time.LocalDate;
import java.util.Objects;

public class Todo {
    private int id;
    private String user;

    @Size(min = 10, message = "Enter atleast 10 Characters.")
    private String desc;
    private LocalDate targetDate;
    private boolean isDone;

    public Todo() {
        super();
    }

    public Todo(int id, String user, String desc, LocalDate targetDate, boolean isDone) {
        super();
        this.id = id;
        this.user = user;
        this.desc = desc;
        this.targetDate = targetDate;
        this.isDone = isDone;
    }

    // For backward compatibility with existing code that uses java.util.Date
    public Todo(int id, String user, String desc, java.util.Date targetDate, boolean isDone) {
        super();
        this.id = id;
        this.user = user;
        this.desc = desc;
        this.targetDate = targetDate != null ? 
            LocalDate.ofInstant(targetDate.toInstant(), java.time.ZoneId.systemDefault()) : 
            null;
        this.isDone = isDone;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public LocalDate getTargetDate() {
        return targetDate;
    }

    public void setTargetDate(LocalDate targetDate) {
        this.targetDate = targetDate;
    }

    public boolean isDone() {
        return isDone;
    }

    public void setDone(boolean isDone) {
        this.isDone = isDone;
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        Todo other = (Todo) obj;
        return id == other.id;
    }

    @Override
    public String toString() {
        return String.format(
                "Todo [id=%s, user=%s, desc=%s, targetDate=%s, isDone=%s]", id,
                user, desc, targetDate, isDone);
    }
}