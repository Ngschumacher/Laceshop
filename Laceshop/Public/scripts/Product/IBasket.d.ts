declare module App {
    interface IProduct {
        variantAttributes: Array<IVariantAttribute>;
        imageUrls: Array<string>;
    }
    interface IVariantAttribute {
        key: string;
        name: string;
        options: Array<IOption>;
    }
    interface IOption {
        key: string;
        name: string;
        selected: boolean;
    }
}
