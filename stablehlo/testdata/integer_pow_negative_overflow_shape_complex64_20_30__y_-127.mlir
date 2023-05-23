// RUN-DISABLED(#1278): stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt -inline | stablehlo-translate --interpret
// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = call @inputs() : () -> tensor<20x30xcomplex<f32>>
    %1 = call @expected() : () -> tensor<20x30xcomplex<f32>>
    %2 = stablehlo.multiply %0, %0 : tensor<20x30xcomplex<f32>>
    %3 = stablehlo.multiply %0, %2 : tensor<20x30xcomplex<f32>>
    %4 = stablehlo.multiply %2, %2 : tensor<20x30xcomplex<f32>>
    %5 = stablehlo.multiply %3, %4 : tensor<20x30xcomplex<f32>>
    %6 = stablehlo.multiply %4, %4 : tensor<20x30xcomplex<f32>>
    %7 = stablehlo.multiply %5, %6 : tensor<20x30xcomplex<f32>>
    %8 = stablehlo.multiply %6, %6 : tensor<20x30xcomplex<f32>>
    %9 = stablehlo.multiply %7, %8 : tensor<20x30xcomplex<f32>>
    %10 = stablehlo.multiply %8, %8 : tensor<20x30xcomplex<f32>>
    %11 = stablehlo.multiply %9, %10 : tensor<20x30xcomplex<f32>>
    %12 = stablehlo.multiply %10, %10 : tensor<20x30xcomplex<f32>>
    %13 = stablehlo.multiply %11, %12 : tensor<20x30xcomplex<f32>>
    %14 = stablehlo.constant dense<(1.000000e+00,0.000000e+00)> : tensor<complex<f32>>
    %15 = stablehlo.broadcast_in_dim %14, dims = [] : (tensor<complex<f32>>) -> tensor<20x30xcomplex<f32>>
    %16 = stablehlo.divide %15, %13 : tensor<20x30xcomplex<f32>>
    %17 = stablehlo.custom_call @check.eq(%16, %1) : (tensor<20x30xcomplex<f32>>, tensor<20x30xcomplex<f32>>) -> tensor<i1>
    return %17 : tensor<i1>
  }
  func.func private @inputs() -> tensor<20x30xcomplex<f32>> {
    %0 = stablehlo.constant dense<"0xFD5FC2408D81FE3F0D0E8CC0E4B4543F9648D7BBBF9DD2C07E544E4033BB57407FB6B040CD92384009148440AE564C403ACA654084ECAEBFDE85A83EA05D773F0746D13EC22E43404D46A5C00D48F43EFFC4CD3F07A06E3FCDD63BC0C7011F401FA43A40831DB2BFAA9F7840E474BE40F1F342C0F5F76DBFC8FF8040DD0F82BE5D2C23C0A97BCFBE64F7A73F50E72DBF24440CC0B84C60C02CC4D83F47760D4087BFE43EDF9EF43E2D87BE3F3B98D8BF6EBD71BE50390640E92FBABFE3F73CC0D6230240B38DF2BF55529E3FE2B62BBE2F18DCC0C218ED3F300C82BFE1C30DC0F2A6F9BD53138440C7BC8CBF8125B1BF4FED3E3FA24A97BFEE8212BE61584D3FF5B8DEBF9C5BDC3F4034E340C58439C0B57CFE3ED14D70BE3B949EBFCCD508C0CF3E15BF4F82FD3F48FB8FBFC17083BFA92D8140BDE422C029FDA7C00016AD40D5791BC0EF43AFBF9C2E45C0EBC4F7BD13A4A340170F813F2B844BC0F4C90F3F1761093F9C3F224026809F3F5980FABFF5CA3240AD72F0BFA6EF5D40B86A5E40BE0D41BFCF18133E74E7A53FFA0A11BF6ED73F3FB8874540C4B2004097B8993F3652E8BE7CA0033FD7E213402618FEBE275A563F06A94140197AD8BE17382540B357B03F56202B3FAB59F1BF63125C3EDCEC303FD7AA87401937CD3FF2647B3FA31463BF66BC623F0F9B53404024433F573F8F404C372D40A1E608C0B29E6FC00FC54F4060230EC0BC0F8DBE2EB3AA3C5590E440EA218AC0319492BDAF5088C0A9714FBE3DE4BA3F12A522402622A03FE74586C097D63840B71836C02CE8FDBE9271A0BFE3D1D6BFA70C80BD8898B6BC22BFBF3F551601C0D874A0BEBE4DDDBF2906F0BE7CFB6940910A6340F6ADE03E45797DC0C86210BF2D288F3F1E9310401734E93F1A29AABFBC55AEBE7F73A6BEB5858DC0C6418C406CD8E43FE0BD114080248340734142C02ED502C04327CFBF9DBAEF3F56B6574090E931C06A8017BF09D5863F882457406E76F24000428EC06523ABC0BA2800409F955D407A795F408EDFA13FDDD15440A5C19FC065A029406CF22D3FA2052A4056DD95409D8206C08B8B98407165E2BF2D31D13F9436E63FA68752BE55ABF2BF9C522AC04E0545BED73B59C0B82D884070DC0940AD55E33F1B24B440222C74BF768F8340FFC0B9405F1AB3C0B09F80C0AA69FDC0EFFB9E3C37245BC05CA027C02E261BBF82F67C408D29C2BF2A31FCBEFCA9353E56C07CC07EDFCF405F8ACEBFFDE86BBF893F9D404FD025406A8E5840598BF5BE70460840728A4840B39405C080D5A1BF58151DC006CC703E1988F5C0131BB4407610D2BEFF86683F416B7F3FC0C182409B7361BFA15E30C0DF4B9AC0D37712C0C7F661C02C9062C0C70A2940CF1C2DC099F01BBF7C4B01404BA045C07EE6984072305CC090AD46C01382D93F25FD85C01C5134BF7ED9933F3A042740AB191D403E03C3BFDE9A8E3F6305AFBF1062ED40DB333A409E232DC0149AA3BF173807BFF7AEA8C0D1410B40A39DAD3E716353C0D39A1AC06D59A1BEDDB2CDBF16FA454046DAF0BF239138C094D88CBAEA00FF3E13160340C44DEB3F5DDEA7C084F93D40CD4EFDBE169E8140B0BA0540D26063BE541473C04F9C8240429D07C0922AF13F921C25400D7E03409BAD15C0B3ECD6BFB0B78E4035CD31C037D0F83F64238C40C9A7F7BFF6C4BFBEE9665A3E3A0177BFBE63473F1292AD3F55B2534012F81B408C2FF4C07ADC9F3F7E1CCAC0E2332BC04D328DC0DDCF2B408435E8BF7A8B093F2652C33EADE918407A8949C0F24107C0C9187BBF45D877BF2B5E7FC0DD138CC0D09CB6BF818942407F524F409F0498C0F694D1C060D99BC0052F3DBE62438D3FD36637C09B2DFB3F1A539F3FAFF13C3F8CE70241618F10BF6051443FF694F83F9E8CD0BF32107DC03C2A033FD9758FBF5804BB40A5EF53BF20799C3F101379BFD2E8B2BF73C7E63FBF38363FC6218740A6632B40805615C0D929CCBFED51B3BFD553C4BFB67826BF2AF8E7BFAB70963D327523405A9376BFCA9090C056491F40A3D29CC0C7EEF13EC1EAA6BDD7A1833E18E98340561983BF97C57EBFDB04B1BF1DE7824088DF7DC0321E383E86739DBFA98A703F1BDB9ABFC248923FBE7BC1BF877C813FA2A7E73DC5AD33C032B60140688017C0BF6892BCEE4863C0ABEEDC3EA7AC99407D18EBBF9A9110BEAECDB53F69CD1140EFAE84408D5D75BF41EE96C06F4110C007A1C73F26EE92BEC10903BE8137EF407EC6BF3FEC7895BFFA3F65C0FE4B7C3E80CB9C3F7099753F1C4AACBFD7DE4DBFB02226C0D6E1A33F56E130408FF8A1BEEEFF38C0096651C003ED9D40333791407A8D9BBE236CCA3F434B98BE5C6FA5BFC3A2904098F60441B1EDC73F4CFED63F20F69E4093F8DCBFE2D2353FAC1EDCBF05BE5ABF271D24BF0F1187C058FC0EC0BE7A093DAF0385BF5D04A04046198D402C0815C0D3AB733FE0E989400E9809409A2C46BF86E184C00E7BA7BF4CD91A405D3A44BF982E223E55BC30C03B528A3FA6E71B3FDDFDA440ED45A4BE0AA6B140B129BA402ED9154064559DC0E2629DBFC5264DBF5FDDE63D22C6F9BFE121BE4000DBACC0BDA76C40046A78400EDBF3BF8121B9BFF2D0DCBF87EE5EBFB87E1A40C5F83AC01DEAAEC0B1C928BF71D4723F6C8FDABEC01B393F5C665EBEFC34E23F90B2123F9C09963FE6B9A03F4D4E4840EB84C1C0FDDA0041A105953F0A43DFBF688A93BFF8E58C4029D91CC0BE9317BEF32451C0884DE43EC4AE33C0B087903E57828CC0D005CFC0E6C88640A65664C0132E943F240181C08CEBF7BFCC8925406F65713F698491C0110BD23DED609F4050C28940328D25C03202964056FE363E4B55A13FF8358FC0D387ADBFF9F00D3F0548B3BF354284C022B091BF4D5785BF4D871BC0F0834F40A68D393FB310DABF79C0D140DBF3184004ACF6BE665BEEBFEF2AE7C080BA9DBF848B53C0B4214B406F5CB23F74A364C0EAA93C407DA521C078DDF53E7762ECC00E83A84029FB7AC071EBDDC0864D0F404DA7D2C0F7536ABFB602D03F2348EF3F8ADD24406E98BD3FA24F0840DACDDA3EF6D0E93FD04E034174941CC094C4A83FEB938EBDF37A2540120BB83F626B9E4040CE2B401A95E6BEA9F88BBF12D001C0211ED83ED5B270C0131A04404D6720BFE3BBEA3F54D236C0D14DA7C03F255C3F2D31BB40C9C532BF0C84B1BEAD726FC07DE358C038BA94BD1F51D23E74CC52404DC1213F92F7CB40F703D03F14C24DC0CDB511BD17CFCBBFA57ABCBF4BFF9CC0B9F5803F51874E40A70072C054AD20BFAABBB2BE78C9B2BFA965733FEEEFE3BF9AFA4A3E1E7356C0E1B32040945643402E143140713B2D401024FABB5A28EB40F32228C0D37FB3BED55F0A4018B2BCBEBDCB4840A847F23FFE806BC09A4E883F9F7D383FA954D1BF35858EBF7A7F3F40DA752040C994074040A115400CDFB63F9711AE40F795C1BF618E4CC0E66E41BE17539C403062A8401998E73F36A0DEBFF28BBB3FA479684066CB16C0B04B6B40B9B936409BCA5BBF4E17BB3F06FE7740276B754000E050C0FAF345C0F081A33D19D07C40C1D51240250D6A40730B8ABF9B09CCBF4A1784407486EE3FB080B23F61C00840A8DDB63F733F4AC02745573F84743A40AE6D41BFF2F397C05409943DD2AC77C0AD748E40C6708ABCC84936C0521D5DC08AC68CBFEDE1FC3E0A88FBBF3B3FF1BE957F9DBFCE5E2940E4CEF13F45F4ABC061FE89BE0D554040D1B3564088E348C00DC34DBEC8EE784083CEF4BF3BF87F3FD4BCB93FC0E925C0C180AD400149D0C035023740CF485A3E0B7D98BF2171BC3FE22AAE3F2E7D2EBE6EBF8D40D8899840C02B864044D8FC3FF11F00C0238CB3BFAC2C59C059596D3FD056ED3FEB7836C079102B3F2500D33E71F1C13FD755673F7F5514BF933162C0A9C1CAC09BCD2BC0985AAEC0806D7EBF422789BF7BF191BF8A00B03F7A22F4C08C9E043E314B13BF99709CBFF28B06C0B5737B3FDEC003C070455D3F189A5BC0BC1BACC05970953EC9223340C06B55C023D6A5C0D49C9DBFD6A68CC0C16EC6BF4B1211BF6B9F593FD034BEBF9172A03F158B05C08D21C1403038B33F81A5A340C12675C014DA73C02EEF36C07B3A47C0F4219DBF819D32BE3486B23E9D0F3940F4BD32BF73A014BCEFF8EA3F739012C031F23B40B1402FC0F405F53FEC3C243E1B44D13E7D6B5DBF44612A40B679DDC0C8EE85C07DCC7CC0391C9BBFB29A16C08FB47840E043F2BFCB7085C01DF8A9C0E5B26F40F6225F4082E2054086A69BC0C86F7840DC638740F7E889BF3884B540A8E3A1BFCAE660C05E7B0A3F75D9483E559BBCBF75B1E3BEA2471ABF1A1866C0916D584090AA9CC05C74E1BF7EA034C0AF038B40A5E298BF8E43F5BF29D4974050360CBF6686FCC028C9BB3F660AF03EA4FCE63F58F20BBF1A31F63F459ADA3FF7BE27C027BA3B3F8FC053404F9FEABF82946240FE2A02C0AA94AA40CA137F3FD742B7C0AEB9E5BF17815240789F93C094B0B83FA5503640D327984044BBD0C015E3AD402B220BC0309151BF1AE0C73F6906ADBF4A33213F27113F4024E3B8C09662B3C0942C9B4019577BBF8B04F93EFFD65FC04611913F21CA0EC0A637B6C081EBE4C0561C8C3F988D45C0DF2BD5BF44F21240A948E940290711BC8F38F1BEE9C9F23FA5C773C0A4DEC3403D1054C077D4913F4627BB3FF26687C09D630840AC0F17C00711C1BF8A11DEBEA3D302C1A64A1CC091478140B7F5E63ECE2711C0B6FF7E40B2F40AC03BEA5AC0535F4B3FDF40FC3F52B486C02441CA40E8FBBE3F86DB89402E9F563F2285863FAB660D405A9393BEF4826AC0E1F790C0D595833F3DFC64C092ACC2BE78626CBF401493408D8D53C0DC540DC097FD8BC093982B3E24998EBF920FFCBFB3E48240DA8093C0656675BF4C344BC086BA454047E3B9C012FEBF4051E78EC08992244059E036C03E6A89C0297A3D4010532AC0E93A283F9BD92540FD9CCFBF7F0A1540DE9A7A40B656CB3FDBF62940DCD161BF6A1155406B54C43F2891E73EDC4A30C0FE3450BF6BBA074052E110C1AEFB2F4078CDFC3EC7C99FC06E5E7640E19959407AD21B3F89A778400A74E73F6CA6523FAE2C9FC0E7A894C09DB1D73E5FDDF1BFE058A43CB9312D4091AEB63FF36AEEBF51AC18C0F51D5C3F08CCDA3F115CEFBFCFC19EBF849181C048AE00C0F05480C02A0C8C3F185E37C07742943F7FA0E93FBCDB99BFCF4FBCBF9F90BF3FC36682C0DD34073E0B0C4C409E4E93BE39B02BC05C2C44C0B755F5BF38F19040801B6E40A3F9803F99846640E3DD59C02247E5BF90BC593E2D9EDCBFD5E3FEBF23161BC0F4D306408DB351C03D12A6BF21AD3840E70CC340A1BFC9404D85C44077DA0540DDEB1F3F86C252C0E64351C0691651402A62CC402E76FB3F8FBF64402CD3EB3FB35834C019501B40E9B3FAC076D9A03ED73A90BF1AA152C0757D99BF8A62213F25BA88407E44A8C0D576E03FE083AC401D01563F793D833F8F0BB53DC7AE0140D6AE39C0AFC1BBBF1F32EC3F2E00963F732E0E40B71822BD4B869DBEA4E1A3C074C94E40A3FB91BFAB6A963F1AD7CCC091A789BF24938D406F5846C0824FF7C067E65DC03CB8B43FA5BE9AC0CDD5123FF1EE2A4023A8B0408BA9E7BE088D01C06C5F8FBFAB1524C0BD2BC83F1ED973404DCAFB3F84A5CA3F08C2213E12BC913EE6B84AC0F83B9840B32E203FDBA486C088D896C0A36A0F41C9BF98C0B8D5983F3B061BC0A6999B40B9DD54C09B080340073528C07418493F1F6A21C07F458C3EB1650FBFF461AABEF7A3963F88FDAF4023CCC2C0EE50EC408A3E5CC021F2C1BED80A2540A73460C0F4224F40158939C0E677F73C738FE63F62DBE2BF6D240640B077004032B2BC400E74993F476AB63F9EEF4DC06B5A44BE9DAA0EC0444AE73D8EB3963F5F1B96C0D53A44C00236C43F54E306C0518C0D407D790E40850CE83FCC909540FF5BA4C014068BC0867D3FBF20940A3FC762EA400188713EA9D85FBF4A7593BFC9112EBD8E8EE93ECB0B85C066425ABFD4B756BF0FB6FE3FCCC0CA3FB53A4A40FC7EEA40E073BDBE714B15404247844051FD4140B0023C40F7EF513FD8F6E1BF94C063406FB94FC04C3BE7BFB72F9D40D124323F19369C40CE440B3FAD85DD3EAC51E1BDF49EB2BF6D6B853FCB031F40272711407A5EB7C0FBBC6140E5AA4DC0C10A86C0D7B5B5BE13FD96BE1854873FFA7273C03C8A92409AAC494013500D4013E922402B6720BF340E023F6AD28D3EFB7976406B6C55C074CE7EC0F1880A3B840909402FDD0CBF829FBB401EEA1040AAD8CEBFC25D4B3D83C6BC3FB5CCEE408C6F2F4061610040EE5C80BFB514B73FB04E0E404B293D4076FF81C0E195ABBF14D9B5C02AC7D3C0F336BF3CACF7A5BF5BCFA740BA42EABFA493CC3F59C807C0A33F9CBE29F876C0581AF4BF1FE49F3FABC03AC0BAEDB33E908DE93EF56F94C0C8E0D3BFFAAD08C0A9A520BE350B0EC07BAB00C0BACD5C40A62FBF3DD5A3863F7B035C405B2D6D406139CCBF0FA6AABE35677EBF17BA8BBD1DFE0BC099824D4089FE6C40CEE42AC043D144C05C94B83F845320409480DEBF9C2B4C3FBC05C8BD60BAF53F85A4BF4066B5D140F9FF66C0DCE45540DF34EF3FA9307BC02D4689C07A70F6BD9B5A1240962E9AC0100A3D3FDBA3AD3FCC9B83400F5699C0622EB0C011F7A9408E380440B0A3B9BFE9D086404E876D40AEF337400E01DBBF74E884BE8E2DABBFA8541940ADE882C0"> : tensor<20x30xcomplex<f32>>
    return %0 : tensor<20x30xcomplex<f32>>
  }
  func.func private @expected() -> tensor<20x30xcomplex<f32>> {
    %0 = stablehlo.constant dense<"0x000000800000000000000000000000800000C0FF0000C0FF0000C0FF0000C0FF00000000000000800000C0FF0000C0FF0000008000000000A24F623DC50F45BD0000000000000000000000000000008073408086FBD77306000000000000008000000000000000000000C0FF0000C0FF0000008000000000000000800000000000000000000000006E7F459B6AF0919B00000000000000000000008000000000FEA04EE6AC788D65000000800000000000000000000000000000000000000000000000800000000090F2DAA9802824AB0000000000000080000000800000000000000080000000008F68A98A9318340B40348DA089EF912093B198D1131728D200000000000000000000008000000000DB952D76C181CAF500000080000000000000008000000000FC5BE7984297059800000080000000000000C0FF0000C0FF00000000000000000000000000000080000000000000008000000000000000000000008000000000000000800000000000000000000000000000C0FF0000C0FF7C38EAD6EFB2A357E480289FB3209A1F000000000000000000000080000000007FB9B7E12D61D0E1000000800000000000000080000000000000000000000000119125188A853298E7A1D5039A8CBC840000C0FF0000C0FF25DB790578324A85FB1277AA2301962A00000080000000000000C0FF0000C0FF0000C0FF0000C0FF0000008000000000000080FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF632EE99BB59DDA1A00000080000000800000C0FF0000C0FF000000000000000000000000000000800000807F0000C0FF000000800000008007E6948BB9ED950B000000800000000000000080000000000000000000000080000000800000000000000080000000800000807F0000C0FF0000000000000080000000800000008000000000000000800000000000000000000000800000000000000000000000000000008000000000000000000000008000000000000000800000C0FF0000C0FF000000800000000000000000000000800000008000000000000000000000008000000080000000000000008000000000BAA24104A625AC8300000000000000000000C0FF0000C0FF000000000000000000000080000000000000C0FF0000C0FF000000000000008000000080000000000000C0FF0000C0FF000000000000000022524A14C93D9214000000000000000000000000000000800000C0FF0000C0FF00000080000000000000000000000080000000800000008000000080000000000000C0FF0000C0FF0000008000000000A82B742373F0F82300000080000000000000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000000000000000000000000000000000000000000000800000000000000080000000800000000000000080000000000000008000000000690D6D0B506CDC8A00000000000000800000000000000080000000800000000000000080000000800000000000000080042BCB915F6229920000000000000000000000000000000000000000000000000000C0FF0000C0FF0000008000000000000000000000008000000000000000000000008000000000000000000000000000000080000000000000C0FF0000C0FF000000000000008000000000000000800000807F0000C0FFFD7B5C2A3D54BE2B00000000000000000000C0FF0000C0FF0000C0FF0000C0FF00000000000000800000000000000000D77EAAE53B3A2EE4000000800000000000000000000000800000008000000000000000000000008000000080000000000000C0FF0000C0FF0000000000000080000000800000000000000080000000000000C0FF0000C0FF05C7D8C31BA66B43000000000000000000000000000000000000C0FF0000C0FF5B8A9D1A201EC01B293BA90E349EB30DA9FDAB8233A97A02000000000000008000000000000000000000000000000080371E6382B05D738300000000000000000000C0FF0000C0FF0000C0FF0000C0FF0000807F0000C0FF00000080000000009A98B41E729A549E0000C0FF0000C0FF0000000000000000887AC496FDFD6297F401FB0FE3DFC19036F59388BE2720080000000000000000000000800000000000000000000000000000C0FF0000C0FFD6E67E07BFE8A786000000800000000000000000000000800000C0FF0000C0FF7A50A094CF2025950000C0FF0000C0FF74038084DC526A0400000000000000802E8EE79675155C96192B1196B77AFE95000000000000008000000080000000000000C0FF0000C0FF0000C0FF0000C0FF9B8EB2934D7157138DE806A5936B8A25000000000000008000000080000000000000000000000080F9F016069DDC82861D0270B90BF277370000008000000000C4ADBE3BBDCA853B0000008000000000000000000000000000000000000000800000C0FF0000C0FF00000000000000006252AED5A395A0D500000000000000000000C0FF0000C0FF0000C0FF0000C0FF000000000000008000000000000000801A4E46D21E6CC3520000C0FF0000C0FF0000C0FF0000C0FF0000008000000000000000000000008000000000000000000000C0FF0000C0FF5FCE3A321EEB02B1B3367ECF2E093E4EB9A95E099FB19A8A02FC0EA74D3A5F260000000000000000000000800000000000000000000000000000C0FF0000C0FF00000000000000000000000000000000000000000000008000000080000000000000C0FF0000C0FF0000C0FF0000C0FF00000000000000000000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF00000080000000000000C0FF0000C0FF53241A9C1EA35C1C0000C0FF0000C0FFC597B897827D2F960000008000000000E20ACF8684D8C0860000C0FF0000C0FFDA8A3E03A518528300000080000000000000000000000080000000800000000000000080000000000000C0FF0000C0FF0000C0FF0000C0FF000000800000000000000000000000800000008000000080000000800000000000000000000000000000C0FF0000C0FF000000800000000000000080000000000000C0FF0000C0FF000000800000000000000000000000800000008000000000000000000000000000000080000000000000000000000080000000000000008000000080000000000000000000000000000000800000008000000000000000800000008000000000E061FE13683DCA140000C0FF0000C0FF00000080000000000000000000000000BECB379D58250E9E00000000000000800000008000000000000000800000000000000080000000000000C0FF0000C0FF00000000000000800000008000000000000000000000000000000000000000003727FB89B307170A000000000000000000000080000000800000000000000000000000800000000000000000000000000000008000000000000000800000000000000000000000000000C0FF0000C0FF000000800000008000000080000000000000C0FF0000C0FF0000000000000000000000800000000000000080000000800000C0FF0000C0FF000000000000000000000000000000000000000000000080000000800000000000000080000000000000C0FF0000C0FF000000000000000000000000000000000000000000000080E51FDE2594B1092600000080000000000000C0FF0000C0FF0000C0FF0000C0FF0000000000000000000000800000000071AA898BFE31C50A00000080000000000000008000000000D9087A2DC43AE72D00000000000000800000C0FF0000C0FF00000080000000000000000000000000000000800000000000000080000000000000000000000000851CED95C16FD895D3DCFEB8A12D9FB70000C0FF0000C0FF0000C0FF0000C0FF3B796C1C6068859CAA7E0D88931F510A0000008000000000604194A3EB23BBA3000000000000000000000080000000000000C0FF0000C0FF00000080000000000000C0FF0000C0FF0000C0FF0000C0FF82467B91BBAC1111C309610BD80D340E000000800000008000000080000000000000C0FF0000C0FF0000C0FF0000C0FF00000000000000800000807F0000C0FF0000008000000080F37874072F81A807000000000000000000000000000000800000807F0000C0FF00000000000000000000C0FF0000C0FF000000800000000000000080000000000000C0FF0000C0FF0000008000000000000000000000000000000000000000800000C0FF0000C0FF00000000000000800000000000000080E318131BEF37961A84BAC9D9531092D90000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF000000000000000000000000000000800000000000000080CD2730864328160600000080000000800000000000000000000000800000000000000080000000000000C0FF0000C0FF0000C0FF0000C0FF00000000000000000000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF00000000000000000000008000000000000000800000000000000080000000000000C0FF0000C0FF000000000000000000000080000000000000C0FF0000C0FF000000000000000000000080000000000000000000000080C3718E81BA680302000000800000000000000000000000000000C0FF0000C0FF000000000000000094E9B71533001096000000800000000000000000000000800000C0FF0000C0FF000000000000000000000000000000000000C0FF0000C0FF0000C0FF0000C0FF7B730C24F70D29A400000080000000800000C0FF0000C0FF000000000000000057F73ABF2F3672BF00000000000000800000C0FF0000C0FFF50AFFB2F6568EB40000008000000000000000000000008000000000000000800000C0FF0000C0FF00000080000000000000C0FF0000C0FF000000800000008000000080000000000000000000000000000000000000008000000080000000000000008000000000000000800000000000000000000000000000C0FF0000C0FF00000080000000000000008000000000000000800000000000000080000000000000C0FF0000C0FFF6604982DB3FE402000000800000000000000080000000000000008000000000000000800000008000000000000000800000C0FF0000C0FF00000080000000000000008000000080796B8C842A06438400000000000000800000000000000000000000000000000000000000000000000000C0FF0000C0FF000000800000008000000000000000801D405E8BDB3BE80C0000000000000080000000800000000000000000000000800000C0FF0000C0FF0000008000000000000000000000000000000000000000800000C0FF0000C0FF000000800000000000000000000000800000008000000000000000800000000047C288A226DFA1230000C0FF0000C0FF0000C0FF0000C0FF8189BC25E02B422500000000000000000000000000000000000000800000000000000080000000000000C0FF0000C0FF00000080000000800000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000000000000000000000800000000000000080000000000000000000000000000000000000000000000000000000000000008000000000000080FF0000C0FF0000C0FF0000C0FF00000000000000800000C0FF0000C0FF00000080000000000000C0FF0000C0FF000000000000008000000000000000000000000000000080C04E38E6A1239BE60000C0FF0000C0FF000000000000008000000000000000000000C0FF0000C0FF0000000000000080A705718981BD168900000000000000000000C0FF0000C0FF31EC4A86FED12F06000000000000000000000000000000800000000000000080000000000000008000000000000000800000008000000000000000000000008000000080000000000000C0FF0000C0FF6BC87DC83B9602485329E92F98A276B200000080000000006C51142E503D0FAF00000080000000000000C0FF0000C0FF00000000000000000000008000000000000000800000000000000000000000000000000000000000000000800000000000000080000000000000807F0000C0FF38419D8C8A2F830B00000000000000000000C0FF0000C0FF0000000000000080000080FF0000C0FF00000080000000000000C0FF0000C0FF00000080000000807208ACD17DB923530000008000000000000000800000000000000080000000000000C0FF0000C0FF0000008000000000357ABD1B09B6319B0000C0FF0000C0FF000000800000000000000080000000800000C0FF0000C0FF0000C0FF0000C0FF00000080000000000000C0FF0000C0FF000000000000000000000000000000800000008000000000000000800000000039080BF28C177FF0000000000000008000000000000000000000000000000080000000800000000000000080000000000000008000000000C13029BAEE38213B00000080000000000000C0FF0000C0FF00000080000000000000008000000080B90F48036EA2090406455302FDB0970300000080000000000000C0FF0000C0FF000000000000008000000000000000800000000000000080D5A71597020C91170000008000000000000000000000008000000080000000000000008000000000000000800000008008FAE6A2A5B4E7A20000C0FF0000C0FF"> : tensor<20x30xcomplex<f32>>
    return %0 : tensor<20x30xcomplex<f32>>
  }
}
