import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:test/test.dart';
import 'package:on_chain/solana/solana.dart';

void main() {
  group("vote layout", () {
    _initializeAccount();
    _authorize();
    _authorizeWithSeed();
    _withdraw();
    _voteAccount();
  });
}

void _initializeAccount() {
  test("initializeAccount", () {
    final owner = SolAddress("HcEjuQ7Eate3eyNBaZV2cwATcdAH8F7VGygVqkkoqUjf");
    final layout = VoteProgramInitializeAccountLayout(
        authorizedVoter:
            SolAddress("57BYVwU1nZvkDkQZvqnNL71SE4jvegfGoEr6Eo6QgNyJ"),
        authorizedWithdrawer:
            SolAddress("57BYVwU1nZvkDkQZvqnNL71SE4jvegfGoEr6Eo6QgNyJ"),
        commission: 1,
        nodePubkey: owner);
    expect(layout.toHex(),
        "00000000f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d3d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d01");

    final decode =
        VoteProgramInitializeAccountLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _authorize() {
  test("authorize", () {
    final newAuthorized =
        SolAddress("57BYVwU1nZvkDkQZvqnNL71SE4jvegfGoEr6Eo6QgNyJ");
    final layout = VoteProgramAuthorizeLayout(
        newAuthorized: newAuthorized, voteAuthorizationType: 1);
    expect(layout.toHex(),
        "010000003d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d01000000");
    final decode = VoteProgramAuthorizeLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _authorizeWithSeed() {
  test("authorizeWithSeed", () {
    final account = SolAddress("57BYVwU1nZvkDkQZvqnNL71SE4jvegfGoEr6Eo6QgNyJ");
    final owner = SolAddress("HcEjuQ7Eate3eyNBaZV2cwATcdAH8F7VGygVqkkoqUjf");
    final layout = VoteProgramAuthorizeWithSeedLayout(
        newAuthorized: account,
        voteAuthorizationType: 1,
        currentAuthorityDerivedKeySeed: "account1",
        currentAuthorityDerivedKeyOwnerPubkey: owner);
    expect(layout.toHex(),
        "0a00000001000000f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd7608000000000000006163636f756e74313d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d");
    final decode =
        VoteProgramAuthorizeWithSeedLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _withdraw() {
  test("withdraw", () {
    final layout = VoteProgramWithdrawLayout(lamports: BigInt.from(25000));

    expect(layout.toHex(), "03000000a861000000000000");
    final decode = VoteProgramWithdrawLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _voteAccount() {
  const String data =
      "01000000c82985c1f95ca67cf6e42fefece691083abc954f72a9733c93fea822246e5d79fd6b76c9327f3cd62ebbdcce619a0e582c51d4dd98f91aaa5ac23ef8f0fbad265a1f0000000000000024e9bc09000000001f00000025e9bc09000000001e00000026e9bc09000000001d00000027e9bc09000000001c00000028e9bc09000000001b00000029e9bc09000000001a0000002ae9bc0900000000190000002be9bc0900000000180000002ce9bc0900000000170000002de9bc0900000000160000002ee9bc0900000000150000002fe9bc09000000001400000030e9bc09000000001300000031e9bc09000000001200000032e9bc09000000001100000033e9bc09000000001000000034e9bc09000000000f00000035e9bc09000000000e00000036e9bc09000000000d00000037e9bc09000000000c00000038e9bc09000000000b00000039e9bc09000000000a0000003ae9bc0900000000090000003be9bc0900000000080000003ce9bc0900000000070000003de9bc0900000000060000003ee9bc0900000000050000003fe9bc09000000000400000040e9bc09000000000300000041e9bc09000000000200000042e9bc0900000000010000000123e9bc090000000001000000000000007a01000000000000c82985c1f95ca67cf6e42fefece691083abc954f72a9733c93fea822246e5d790000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001f00000000000000010600000000000000740100000000000010640200000000000000000000000000750100000000000098bb0200000000001064020000000000770100000000000089ff06000000000098bb020000000000780100000000000028d108000000000089ff060000000000790100000000000088380a000000000028d10800000000007a01000000000000c76e0b000000000088380a000000000042e9bc090000000026f9296300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  test("description", () {
    VoteAccount.fromBuffer(BytesUtils.fromHexString(data));
  });
}