CREATE TABLE IF NOT EXISTS ohlcv (
    ts TIMESTAMPTZ NOT NULL,
    symbol TEXT NOT NULL,
    open NUMERIC, 
    high NUMERIC,
    low NUMERIC,
    close NUMERIC,
    volume NUMERIC,
    timeframe TEXT NOT NULL DEFAULT '1h',
    
    PRIMARY KEY (symbol, timeframe, ts)
);
