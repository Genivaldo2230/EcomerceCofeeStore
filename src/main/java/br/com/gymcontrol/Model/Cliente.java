package br.com.gymcontrol.Model;

import java.sql.Date;

public class Cliente {
    private int id;
    private String nomeCompleto;
    private String email;
    private Date dataNascimento;
    private String genero;

    private String cpf;
    private String senha;
    private String cepFaturamento;
    private String logradouroFaturamento;
    private int numeroFaturamento;
    private String complementoFaturamento;
    private String bairroFaturamento;
    private String cidadeFaturamento;
    private String ufFaturamento;

    private int idEnderecoPadrao;

    public Cliente() {
    }

    public Cliente(int id, String nomeCompleto, String email, Date dataNascimento, String genero, String cpf, String senha, String cepFaturamento, String logradouroFaturamento, int numeroFaturamento, String complementoFaturamento, String bairroFaturamento, String cidadeFaturamento, String ufFaturamento) {
        this.id = id;
        this.nomeCompleto = nomeCompleto;
        this.email = email;
        this.dataNascimento = dataNascimento;
        this.genero = genero;
        this.cpf = cpf;
        this.senha = senha;
        this.cepFaturamento = cepFaturamento;
        this.logradouroFaturamento = logradouroFaturamento;
        this.numeroFaturamento = numeroFaturamento;
        this.complementoFaturamento = complementoFaturamento;
        this.bairroFaturamento = bairroFaturamento;
        this.cidadeFaturamento = cidadeFaturamento;
        this.ufFaturamento = ufFaturamento;
    }

    public Cliente(int id, String nomeCompleto, String email, Date dataNascimento, String genero, String cpf, String senha, String cepFaturamento, String logradouroFaturamento, int numeroFaturamento, String complementoFaturamento, String bairroFaturamento, String cidadeFaturamento, String ufFaturamento, int idEnderecoPadrao) {
        this.id = id;
        this.nomeCompleto = nomeCompleto;
        this.email = email;
        this.dataNascimento = dataNascimento;
        this.genero = genero;
        this.cpf = cpf;
        this.senha = senha;
        this.cepFaturamento = cepFaturamento;
        this.logradouroFaturamento = logradouroFaturamento;
        this.numeroFaturamento = numeroFaturamento;
        this.complementoFaturamento = complementoFaturamento;
        this.bairroFaturamento = bairroFaturamento;
        this.cidadeFaturamento = cidadeFaturamento;
        this.ufFaturamento = ufFaturamento;
        this.idEnderecoPadrao = idEnderecoPadrao;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNomeCompleto() {
        return nomeCompleto;
    }

    public void setNomeCompleto(String nomeCompleto) {
        this.nomeCompleto = nomeCompleto;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCpf() {
        return cpf;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public String getCepFaturamento() {
        return cepFaturamento;
    }

    public void setCepFaturamento(String cepFaturamento) {
        this.cepFaturamento = cepFaturamento;
    }

    public String getLogradouroFaturamento() {
        return logradouroFaturamento;
    }

    public void setLogradouroFaturamento(String logradouroFaturamento) {
        this.logradouroFaturamento = logradouroFaturamento;
    }

    public int getNumeroFaturamento() {
        return numeroFaturamento;
    }

    public void setNumeroFaturamento(int numeroFaturamento) {
        this.numeroFaturamento = numeroFaturamento;
    }

    public String getComplementoFaturamento() {
        return complementoFaturamento;
    }

    public void setComplementoFaturamento(String complementoFaturamento) {
        this.complementoFaturamento = complementoFaturamento;
    }

    public String getBairroFaturamento() {
        return bairroFaturamento;
    }

    public void setBairroFaturamento(String bairroFaturamento) {
        this.bairroFaturamento = bairroFaturamento;
    }

    public String getCidadeFaturamento() {
        return cidadeFaturamento;
    }

    public void setCidadeFaturamento(String cidadeFaturamento) {
        this.cidadeFaturamento = cidadeFaturamento;
    }

    public String getUfFaturamento() {
        return ufFaturamento;
    }

    public void setUfFaturamento(String ufFaturamento) {
        this.ufFaturamento = ufFaturamento;
    }

    public Date getDataNascimento() {
        return dataNascimento;
    }

    public void setDataNascimento(Date dataNascimento) {
        this.dataNascimento = dataNascimento;
    }

    public String getGenero() {
        return genero;
    }

    public void setGenero(String genero) {
        this.genero = genero;
    }

    public int getIdEnderecoPadrao() {
        return idEnderecoPadrao;
    }

    public void setIdEnderecoPadrao(int idEnderecoPadrao) {
        this.idEnderecoPadrao = idEnderecoPadrao;
    }
}
