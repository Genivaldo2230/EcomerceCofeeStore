package Model;

import br.com.gymcontrol.Model.ItemCarrinho;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;

public class Pedido {
    private int id;
    private int clienteId;
    private String status;
    private BigDecimal valorTotal;
    private int enderecoEntregaId;
    private String formaPagamento;

    private Timestamp dataPedido;
    private ArrayList<ItemCarrinho> itensPedido;

    // Construtores, getters e setters

    // Exemplo de construtor
    public Pedido(int clienteId, String status, BigDecimal valorTotal, int enderecoEntregaId, String formaPagamento) {
        this.clienteId = clienteId;
        this.status = status;
        this.valorTotal = valorTotal;
        this.enderecoEntregaId = enderecoEntregaId;
        this.formaPagamento = formaPagamento;
    }

    public Pedido(int id, String status, BigDecimal valorTotal, Timestamp dataPedido) {
        this.id = id;
        this.status = status;
        this.valorTotal = valorTotal;
        this.dataPedido = dataPedido;
    }

    public Pedido() {
    }

    // Ajuste no método setItensPedido para adicionar itens
    public void setItensPedido(ArrayList<ItemCarrinho> itensPedido) {
        this.itensPedido = itensPedido;
    }

    // Adiciona um item ao pedido
    public void adicionarItemPedido(ItemCarrinho itemCarrinho) {
        if (itensPedido == null) {
            itensPedido = new ArrayList<ItemCarrinho>();
        }
        itensPedido.add(itemCarrinho);
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getClienteId() {
        return clienteId;
    }

    public void setClienteId(int clienteId) {
        this.clienteId = clienteId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public BigDecimal getValorTotal() {
        return valorTotal;
    }

    public void setValorTotal(BigDecimal valorTotal) {
        this.valorTotal = valorTotal;
    }

    public int getEnderecoEntregaId() {
        return enderecoEntregaId;
    }

    public void setEnderecoEntregaId(int enderecoEntregaId) {
        this.enderecoEntregaId = enderecoEntregaId;
    }

    public String getFormaPagamento() {
        return formaPagamento;
    }

    public void setFormaPagamento(String formaPagamento) {
        this.formaPagamento = formaPagamento;
    }

    public ArrayList<ItemCarrinho> getItensPedido() {
        return itensPedido;
    }

    public Timestamp getDataPedido() {
        return dataPedido;
    }

    public void setDataPedido(Timestamp dataPedido) {
        this.dataPedido = dataPedido;
    }
}
