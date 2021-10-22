-module(nxtfr_event).
-author("christian@flodihn.se").

%% External exports
-export([
    add_handler/1,
    add_global_handler/2,
    notify/1,
    notify_global/2,
    delete_handler/1,
    delete_global_handler/2
    ]).

add_handler(Handler) ->
    gen_event:add_sup_handler(nxtfr_event, Handler, []).

add_global_handler(EventManager, Handler) ->
    case global:whereis_name(EventManager) of
        undefined ->
            nxtfr_global_event_sup:start(EventManager);
        _Pid ->
            pass
    end,
    gen_event:add_sup_handler({global, EventManager}, Handler, []).

notify(Event) ->
    gen_event:notify(nxtfr_event, Event).

notify_global(EventManager, Event) ->
    gen_event:notify({global, EventManager}, Event).

delete_handler(Handler) ->
    gen_event:delete_handler(nxtfr_event, Handler, []).

delete_global_handler(EventManager, Handler) ->
    global:whereis_name(EventManager) =/= undefined orelse throw(no_event_manager),
    gen_event:delete_handler({global, EventManager}, Handler, []).