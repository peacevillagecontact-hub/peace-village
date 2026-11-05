-- Security hardening (session 10): two SECURITY DEFINER functions were flagged by the
-- Supabase security advisor as directly callable via public PostgREST RPC
-- (POST /rest/v1/rpc/<function_name>) by the anon/authenticated roles, even though
-- neither is meant to be called that way — notify_new_entry() only runs as an AFTER
-- INSERT trigger, and rls_auto_enable() only runs as a DDL event trigger.
--
-- First attempt: revoke from the two named roles directly. (Superseded by
-- lock_down_security_definer_functions_v2 — see that migration for why this alone was
-- insufficient: Postgres also grants EXECUTE to PUBLIC by default on function creation,
-- and anon/authenticated inherit through PUBLIC membership.)

revoke execute on function public.notify_new_entry() from anon, authenticated;
revoke execute on function public.rls_auto_enable() from anon, authenticated;
