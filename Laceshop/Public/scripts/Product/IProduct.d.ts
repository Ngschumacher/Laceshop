declare module App {
    interface IProduct {
        VariantOptions: Array<IVariantOption>;
        Variants: Array<IVariant>;
        ImageUrls: Array<string>;
    }
    interface IVariant {
        Attributes: Array<IVariantAttribute>;
        ImageUrls: Array<string>;
        Key: string;
        Name: string;
    }
    interface IVariantAttribute {
        Key: string;
        Name: string;
        Value: IAttributeOption;
    }
    interface IAttributeOption {
        Key: string;
        Name: string;
        Selected: string;
    }
    interface IVariantOption {
        Key: string;
        Name: string;
        Options: Array<IOptionValue>;
        model: string;
    }
    interface IOptionValue {
        Key: string;
        Name: string;
        Selected: boolean;
    }
}
