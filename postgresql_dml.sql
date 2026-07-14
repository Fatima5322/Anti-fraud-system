INSERT INTO transaction (
    transaction_id,
    sender_account,
    recipient_account,
    amount,
    currency,
    transaction_date,
    ip_address,
    origin_country,
    device_id,
    payment_channel,
    tariff
)
VALUES
(
    '5a5cb1d2-38e5-4d39-b6a0-215dfe4e7138',
    'NL91ABNA0417164300',
    'NL20INGB0001234567',
    1500.50,
    'EUR',
    '2026-07-01 15:30:00',
    '192.168.10.15',
    'NL',
    'device-f3c91d88',
    'MOBILE_APP',
    'Premium'
);

INSERT INTO fraud_check (
    check_id,
    transaction_id,
    status,
    risk_level,
    rules_decision,
    automatic_decision,
    final_decision,
    created_at,
    completed_at
)
VALUES
(
    '7df76e95-9e5b-4aef-b09e-f7ab826afdf6',
    '5a5cb1d2-38e5-4d39-b6a0-215dfe4e7138',
    'COMPLETED',
    'MEDIUM',
    'MANUAL_REVIEW',
    'MANUAL_REVIEW',
    'APPROVED',
    '2026-07-01 15:30:01',
    '2026-07-01 16:05:17'
);

INSERT INTO manual_review (
    review_id,
    check_id,
    mr_status,
    comment,
    final_decision,
    created_at,
    completed_at
)
VALUES
(
    'f44bdb95-5b34-4328-8d63-b37b44d5eaf4',
    '7df76e95-9e5b-4aef-b09e-f7ab826afdf6',
    'COMPLETED',
    'Transaction verified. No fraud indicators detected.',
    'APPROVED',
    '2026-07-01 15:30:08',
    '2026-07-01 16:05:17'
);

INSERT INTO fraud_check_rule (
    check_id,
    rule_id
)
VALUES
(
    '7df76e95-9e5b-4aef-b09e-f7ab826afdf6',
    '2b9fa56f-1980-4cf9-9dcb-91b89cbff6cb'
),
(
    '7df76e95-9e5b-4aef-b09e-f7ab826afdf6',
    '91f3bb9b-6227-40c4-84fa-58d7bc6d1b21'
);

INSERT INTO fraud_rule (
    rule_id,
    rule_name,
    rule_description,
    is_active,
    created_at,
    updated_at
)
VALUES
(
    '2b9fa56f-1980-4cf9-9dcb-91b89cbff6cb',
    'Крупная сумма',
    'Запускает дополнительную проверку при переводах на сумму свыше 100000 EUR',
    TRUE,
    '2026-06-25 09:00:00',
    '2026-06-28 12:15:43'
);