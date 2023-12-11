package br.com.gymcontrol.Model;

public class UsuarioBackOffice {
    private int ID;
    private String Nome;
    private String Email;
    private String Senha;
    private String Grupo;
    private boolean Status;

    private String CPF;

    public UsuarioBackOffice() {
    }

    public UsuarioBackOffice(int ID, String nome, String email, String senha, String grupo, boolean status, String CPF) {
        this.ID = ID;
        Nome = nome;
        Email = email;
        Senha = senha;
        this.Grupo = grupo;
        Status = status;
        this.CPF = CPF;
    }

    public UsuarioBackOffice(int ID, String nome, String grupo) {
        this.ID = ID;
        this.Nome = nome;
        this.Grupo = grupo;

    }


    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getNome() {
        return Nome;
    }

    public void setNome(String nome) {
        Nome = nome;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String email) {
        Email = email;
    }

    public String getSenha() {
        return Senha;
    }

    public void setSenha(String senha) {
        Senha = senha;
    }

    public String getGrupo() {
        return Grupo;
    }

    public void setGrupo(String grupo) {
        Grupo = grupo;
    }

    public boolean getStatus() {
        return Status;
    }

    public void setStatus(boolean status) {
        Status = status;
    }

    public String getCPF() {
        return CPF;
    }

    public void setCPF(String CPF) {
        this.CPF=CPF;

    }
}
