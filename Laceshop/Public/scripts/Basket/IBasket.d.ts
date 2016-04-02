declare module App {
    interface IBasket {
        name: string;
        TotalBasketPrice: number;
        allowBasketEdit: boolean;
        Items: Array<IBasketLine>;
    }
    interface IBasketLine {
        Key: string;
        Name: string;
        Price: number;
        Quantity: number;
    }
}
