%%%-------------------------------------------------------------------
%% @doc nxtfr_event top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(nxtfr_event_sup).

-behaviour(supervisor).

-export([start_link/0]).

-export([init/1]).

-define(SERVER, ?MODULE).

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

init([]) ->
    SupFlags = #{
        strategy => one_for_one,
        intensity => 1,
        period => 5},

    NxtfrEvent = #{
        id => nxtfr_event,
        start => {gen_event, start_link, [{local, nxtfr_event}]}
        },

    NxtfrGlobalEventSup = #{
        id => nxtfr_global_event,
        start => {nxtfr_global_event_sup, start_link, []},
        type => supervisor
        },

    ChildSpecs = [NxtfrEvent, NxtfrGlobalEventSup],
    {ok, {SupFlags, ChildSpecs}}.

%% internal functions
