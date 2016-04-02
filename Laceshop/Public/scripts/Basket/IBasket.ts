module App {
    export interface IBasket {
        name : string;
        TotalBasketPrice: number; 
        allowBasketEdit: boolean;
        Items : Array<IBasketLine>;
    }
    export interface IBasketLine {
        Key: string;
        Name: string;
        Price: number;
        Quantity : number;
    }
}