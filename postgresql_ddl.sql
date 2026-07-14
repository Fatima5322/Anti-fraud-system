CREATE TABLE transaction (
    transaction_id UUID PRIMARY KEY,
    sender_account VARCHAR(34) NOT NULL,
    recipient_account VARCHAR(34) NOT NULL,
    amount NUMERIC(15,2) NOT NULL,
    currency VARCHAR(3) NOT NULL,
    transaction_date TIMESTAMP NOT NULL,
    ip_address VARCHAR(45) NOT NULL,
    origin_country VARCHAR(2) NOT NULL,
    device_id VARCHAR(255) NOT NULL,
    payment_channel VARCHAR(10) NOT NULL,
    tariff VARCHAR(50) NOT NULL,

    CHECK (amount > 0),
    CHECK (payment_channel IN (
        'MOBILE_APP',
        'WEB'
    ))
);

CREATE TABLE fraud_check (
    check_id UUID PRIMARY KEY,
    transaction_id UUID NOT NULL UNIQUE,
    status VARCHAR(11) NOT NULL,
    risk_level VARCHAR(7),
    rules_decision VARCHAR(13),
    automatic_decision VARCHAR(13),
    final_decision VARCHAR(8),
    created_at TIMESTAMP NOT NULL,
    completed_at TIMESTAMP,

    FOREIGN KEY (transaction_id)
        REFERENCES transaction(transaction_id),
    CHECK (status IN (
        'IN_PROGRESS',
        'MANUAL_REVIEW',
        'COMPLETED'
    )),
    CHECK (
        risk_level IS NULL
        OR risk_level IN (
            'LOW',
            'MEDIUM',
            'HIGH',
            'UNKNOWN'
        )
    ),
    CHECK (
        rules_decision IS NULL
        OR rules_decision IN (
            'APPROVED',
            'REJECTED',
            'MANUAL_REVIEW'
        )
    ),
    CHECK (
        automatic_decision IS NULL
        OR automatic_decision IN (
            'APPROVED',
            'REJECTED',
            'MANUAL_REVIEW'
        )
    ),
    CHECK (
        final_decision IS NULL
        OR final_decision IN (
            'APPROVED',
            'REJECTED'
        )
    )
);

CREATE TABLE manual_review (
    review_id UUID PRIMARY KEY,
    check_id UUID NOT NULL UNIQUE,
    mr_status VARCHAR(11) NOT NULL,
    comment TEXT,
    final_decision VARCHAR(8),
    created_at TIMESTAMP NOT NULL,
    completed_at TIMESTAMP,

    FOREIGN KEY (check_id)
        REFERENCES fraud_check(check_id),
    CHECK (mr_status IN (
        'IN_PROGRESS',
        'COMPLETED'
    )),
    CHECK (
        final_decision IS NULL
        OR final_decision IN (
            'APPROVED',
            'REJECTED'
        )
    )
);

CREATE TABLE fraud_rule (
    rule_id UUID PRIMARY KEY,
    rule_name VARCHAR(30) NOT NULL,
    rule_description TEXT NOT NULL,
    is_active BOOLEAN NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP
);

CREATE TABLE fraud_check_rule (
    check_id UUID NOT NULL,
    rule_id UUID NOT NULL,

    PRIMARY KEY (check_id, rule_id),
    FOREIGN KEY (check_id)
        REFERENCES fraud_check(check_id),
    FOREIGN KEY (rule_id)
        REFERENCES fraud_rule(rule_id)
);