# Picnic MCP + OpenAI Secure MCP Tunnel

This Home Assistant App runs the upstream Picnic MCP server together with the
official OpenAI Secure MCP Tunnel client.

The tunnel client starts Picnic directly over STDIO:

```text
ChatGPT
  |
OpenAI Secure MCP Tunnel
  |
openai/tunnel-client
  | STDIO
mcp-picnic
```

## Configuration

Set:

- `picnic_username`
- `picnic_password`
- `picnic_country_code`
- `openai_api_key` — an OpenAI runtime API key with Tunnels Read + Use
- `tunnel_id` — the Secure MCP Tunnel ID associated with your ChatGPT workspace

Picnic session and device state are persisted in `/data`, so 2FA does not need
to be repeated after every restart.

The tunnel-client health/admin UI is available on port 8080.
