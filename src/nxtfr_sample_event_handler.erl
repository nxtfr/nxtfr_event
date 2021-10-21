-module(nxtfr_sample_event_handler).
-author("christian@flodihn.se").
-behaviour(gen_event).

-export([init/1, handle_event/2, handle_call/2, handle_info/2, code_change/3, terminate/2]).
 
init([]) ->
    {ok, []}.
 
handle_event(sample_event, State) ->
    io:format("Received sample_event.~n", []),
    {ok, State};

handle_event({sample_event, EventArg}, State) ->
    io:format("Received sample_event with eventargs: ~p.~n", [EventArg]),
    {ok, State};

handle_event(_, State) ->
    {ok, State}.
 
handle_call(_, State) ->
    {ok, ok, State}.
 
handle_info(_, State) ->
    {ok, State}.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.
 
terminate(_Reason, _State) ->
    ok.