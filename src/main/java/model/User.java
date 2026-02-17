package model;

public class User {
    private int id;
    private String username = "";
    private String passwordHash = "";
    private String mobile = "";
    private String email = "";
    private String about = "";
    private String createdAt = "";

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username == null ? "" : username; }

    public String getPasswordHash() { return passwordHash; }
    public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash == null ? "" : passwordHash; }

    public String getMobile() { return mobile; }
    public void setMobile(String mobile) { this.mobile = mobile == null ? "" : mobile; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email == null ? "" : email; }

    public String getAbout() { return about; }
    public void setAbout(String about) { this.about = about == null ? "" : about; }

    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt == null ? "" : createdAt; }
}