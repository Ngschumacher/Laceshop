module App {
    export interface IProduct {
        VariantOptions: Array<IVariantOption>;
        Variants : Array<IVariant>;
        ImageUrls: Array<string>;
    }
    export interface IVariant {
        Attributes: Array<IVariantAttribute>;
        ImageUrls : Array<string>;
        Key: string;
        Name: string;

    }
    export interface IVariantAttribute {
        Key: string;
        Name: string;
        Value: IAttributeOption;
    }
    export interface IAttributeOption {
        Key: string;
        Name: string;
        Selected: string;
    }
    export interface IVariantOption {
        Key: string;
        Name: string;
        Options: Array<IOptionValue>;
        model : string;
    }

    export interface IOptionValue {
        Key: string;
        Name: string;
        Selected: boolean;
    }
}