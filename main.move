module MyModule::WarrantyService {
    use aptos_framework::signer;
    use std::vector;
    use std::string;

    struct Product has key, store {
        warranty_months: u64,
        purchase_timestamp: u64,
        services: vector<string::String>,
    }

    public fun register_product(owner: &signer, warranty_months: u64, purchase_timestamp: u64) {
        let product = Product {
            warranty_months,
            purchase_timestamp,
            services: vector::empty<string::String>(),
        };
        move_to(owner, product);
    }

    public fun add_service_record(owner: &signer, service_note: string::String) acquires Product {
        let product = borrow_global_mut<Product>(signer::address_of(owner));
        vector::push_back(&mut product.services, service_note);
    }
}
