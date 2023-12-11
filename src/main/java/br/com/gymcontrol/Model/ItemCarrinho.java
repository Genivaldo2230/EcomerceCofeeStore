package br.com.gymcontrol.Model;

import br.com.gymcontrol.Model.Produtos;

public class ItemCarrinho {
    private Produtos produto;
    private int quantidade;
private double totalComFrete;


    public ItemCarrinho(Produtos produto, int quantidade, double totalComFrete) {
        this.produto = produto;
        this.quantidade = quantidade;
        this.totalComFrete = totalComFrete;
    }

    public Produtos getProduto() {
        return produto;
    }

    public void setProduto(Produtos produto) {
        this.produto = produto;
    }

    public int getQuantidade() {
        return quantidade;
    }

    public void setQuantidade(int quantidade) {
        this.quantidade = quantidade;
    }

    public double getSubtotal() {
        return produto.getPrecoProduto() * quantidade;
    }

    public double getTotalComFrete() {
        return totalComFrete;
    }

    public void setTotalComFrete(double totalComFrete) {
        this.totalComFrete = totalComFrete;
    }
}
