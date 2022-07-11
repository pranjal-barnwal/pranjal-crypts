import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';

export interface _SERVICE {
  'checkBalance' : ActorMethod<[], number>,
  'compound' : ActorMethod<[], number>,
  'myName' : ActorMethod<[], undefined>,
  'topUp' : ActorMethod<[number], undefined>,
  'widthdraw' : ActorMethod<[number], undefined>,
}
