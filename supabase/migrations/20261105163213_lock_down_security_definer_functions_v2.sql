-- Completes the fix started in lock_down_security_definer_functions: Postgres grants
-- EXECUTE to the PUBLIC pseudo-role by default when a function is created, and the
-- anon/authenticated roles inherit through PUBLIC membership — so revoking only from
-- those two named roles left the implicit PUBLIC grant active, and the functions were
-- still callable via public RPC. Revoking from PUBLIC as well closes that.
--
-- Trigger invocation (the only real use of either function) is a separate internal
-- mechanism from role-based SQL/RPC calls, so this does not break the notify_new_entry
-- AFTER INSERT trigger or the rls_auto_enable DDL event trigger. Verified after applying:
-- a live test insert still fired the webhook (checked via net._http_response), and
-- get_advisors(type: "security") returned no remaining lints for either function.

revoke execute on function public.notify_new_entry() from public;
revoke execute on function public.rls_auto_enable() from public;
