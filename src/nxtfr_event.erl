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

add_global_handler(EventHandler, Handler) ->
    gen_event:add_sup_handler({global, EventHandler}, Handler, []).

notify(Event) ->
    gen_event:notify(nxtfr_event, Event).

notify_global(EventManager, Event) ->
    gen_event:notify({global, EventManager}, Event).

delete_handler(Handler) ->
    gen_event:delete_handler(nxtfr_event, Handler).

delete_global_handler(EventManager, Handler) ->
    gen_event:delete_handler({global, EventManager}, Handler).