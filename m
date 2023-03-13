Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8B7C61DA4
	for <webhook@archiver.kernel.org>; Mon, 13 Mar 2023 04:27:42 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web10.12456.1678681658213632042
 for <cip-dev@lists.cip-project.org>;
 Sun, 12 Mar 2023 21:27:39 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.154, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 32D4RIOO029831; Mon, 13 Mar 2023 13:27:19 +0900
X-Iguazu-Qid: 34trbMFXmaIC865g4j
X-Iguazu-QSIG: v=2; s=0; t=1678681634; q=34trbMFXmaIC865g4j; m=j8nqEvpAqrOuf+UjJhS6yL+y9Txum/IngfKHY9gZp6A=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1511) id 32D4RC1N014667
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 13 Mar 2023 13:27:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TpcT1EeoHq7goJVgEfieyVaHCaQZxnZXucTxQXUwTVwXvVzAAiyT4iN79Mt739K319Phx7nVsMDOTLe4vO/O6XkPH3HNV3EAvSpSaGf3N3gufTHdYfj5lyrW7sNwaVPfTpFoF4ni2U2Ck4+qNAk2ahOWvu8uewIrjV3z9JLVPe9KF8Z9+oM6J/BO79vaYlSJZNFGJgRHWD8BbNcY/QnhTQa1bRVQWvMrVr4Wd6jBcMXXXTDdFoqDP3VJ5cUhl3vidEWM/+0eH/qyaSSzjhRRtPVDMTRhgGcpdg8kOgPCxATjSbRNDPonWlc7NJIHtRYU20el6Z8Cq3V82SPOipYJQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ST1VL+Cg3v4hMcAQSzYc6Z7RUR8sS0vJH9srS66Mliw=;
 b=HlABirLirbEIEleqrtES0patDVcfQBncP70dkUiHp83bjB2FsR9YYxr5itO4nCfUOfsBnbaSeawSzRrxZDbhZvhE5WQO/kqubpKRHgcQXpo243LdX89Y30ktw/W079uPS5gO6FoHedjvCF9xg7R9FR//t6ZVFFrf1p8t3Aka4HVW/fr+j5jZS1TIe02Pije2fiUr/kl/5pgjt2h7I4ANYYFDHOnXRVRd810azueD48FOlW0lMeZG+e9B+BPNlhY1g5mz//4Iud4R9gu+YOPUTg+9j+M9hNyGXNaRUrz++iXYuTyzIEcmA5ZmfoiQUFjNbyqTSmQHIzqjksgE3WLAkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>, <uli@fpond.eu>,
        <Chris.Paterson2@renesas.com>, <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release v4.19.276-cip93 and v5.10.173-cip28
Thread-Topic: [ANNOUNCE] Release v4.19.276-cip93 and v5.10.173-cip28
Thread-Index: AdlVZA2aNCFzX31xRSu7khQE2pchWg==
Date: Mon, 13 Mar 2023 04:27:09 +0000
X-TSB-HOP2: ON
Message-ID: <TYWPR01MB9420840010270BB35057B68892B99@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TY3PR01MB12016:EE_
x-ms-office365-filtering-correlation-id: e6bd66ae-2f0d-465f-cbc6-08db237b3610
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yA/uh11UWnoZH4ugqa+vcCvSwdneOm4xkcm5rxOc3nht5z+MoBuqAwMb6vdFDF93sCEwySvMYoE489sqV+iHsp8qs5xy8SuGl/tegYTs2rrA8rSnx8EBJykWzh5xbxEtZMF8z+7FVrZA3u0SIRuy+Bk0kVpMJ4OzPSjwHLe1m28Zl5jwdsdJcSs2ukYvlfRytFDXt8huzD1rEVENngT6tDD/jFw88FBu0gHd2Ag1yyoB+f5YhMq6UDWlcrsqHbEPRJkoG+wIX5Ktyqo3rh36vnqBeRIIFvF5DrF6yfOTPeHcmy9/wAoE8eiFSvRtEB4tRM8zs5YmTAALWLdQc4rYaUCiWaZxeevnGAgdXGSTMvSftlCK0KJE6l3yCJxFOd/+GpA8osQDxkuIRGbenYe6m8fav2svlU5Qn87X41t9N4BNjPUC+hUCdcQ8flGCErEK2YP2qahbl36LMbPPlC6978enboPGExPFMBanXZmhpBKSpcwfbagOKjUn4vxh0O4QQ6yv9LkfoKFirYROx3/uU9p67hAqbxMj+gkEksYg9WPHhaq7hJvYaWkvJgXN0IEcsJoquSTEB+SZ2JY0e3Rdptc2yW1aabOQJ04I8TYIE3aKI85RnmpCcB4ou1KPkVELRf29/icNN5iGcKb8X0yXlAFShQmFn+Jm1zh8exU9DPFVlls/RIUnkDPrAYzAAkNi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(451199018)(38070700005)(86362001)(33656002)(38100700002)(122000001)(55016003)(66446008)(76116006)(4326008)(6916009)(66946007)(66556008)(66476007)(64756008)(8676002)(52536014)(41300700001)(54906003)(8936002)(478600001)(316002)(5660300002)(2906002)(83380400001)(966005)(186003)(71200400001)(9686003)(26005)(7696005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?dHE4MHFRNCtxY21RR1lDb2ZmbTU2Qnl6VkxSZi9qTzcvcTMrZVpmeEJh?=
 =?iso-2022-jp?B?bEJjR09lRWNjK2I1ZDlDNk95VitGbzBMU2dJZDcrcmV0WitPRjdQMExs?=
 =?iso-2022-jp?B?NEl2OUZ0eTBYTWdiWVU2TldPV295Q3RQL1dKSldiU0loRmY2Wjl4RHY3?=
 =?iso-2022-jp?B?aytyRlNhV2pjOGVkZ3Y3QkhZc1BBWEZkOVlKL2ttMmt5dnF0UHNZY1dZ?=
 =?iso-2022-jp?B?RFpwWGx1WFk4VzdIeHFTNzNKTnRMbzhIMStzeExmR25tc09pREE2SmZm?=
 =?iso-2022-jp?B?QU1JcXhQeURuQ0djQmE1Z25yS1d4Z1NXQ0lQUjJOUjkwVG0yVk9UZ1ZR?=
 =?iso-2022-jp?B?amFMVS9OOXBRRCtyOFJVM0RwZkZZendrOXpHYit5MVl2ai9ZYitEd0RU?=
 =?iso-2022-jp?B?b3dPUmxGYU4xdXQ4c1JIMnRqbmltOWdUa1VQZy9vSVBmLzBVSTVhclM3?=
 =?iso-2022-jp?B?eDFiTHIzazdxZ0FrZU5jakZDclBXTSt5dy9DemVZNDBQSlV2M3dESzFD?=
 =?iso-2022-jp?B?bFJLa1BDUTBsRGFmOUFKdkc5ay9xcEZzc2I0YWpRdndGbFA5MzJpYm9S?=
 =?iso-2022-jp?B?V0dkN0pTU0JUMG1XQmtZWWVtZDBlUC9oZ2NlQ0VINFRhYWVPeEVZVnJq?=
 =?iso-2022-jp?B?cklJeW1kV2dhQUlNRGxSK0w3NXFYaWxFSTMyVzYwMVFydGF4ZE5UK21a?=
 =?iso-2022-jp?B?RTVrcEZjMG5lVU9jZ0RUeWNZbW9vK0daS1VOZG5YcEpFdExtdDVzdGlW?=
 =?iso-2022-jp?B?QzM1eWJ4S2FnUGQrRE9RQURoMjB4c0RPSk9nRmduVS9QVHJYOTh0WW80?=
 =?iso-2022-jp?B?LzZDeEFERU9OazVlUnNxOWowMGpEUTdndzlZdm9mSldZNDc5V0NUT2R2?=
 =?iso-2022-jp?B?OUIyTlMxcDNORHE4QlJkVmhTYjN4YkQ4MURIdnB1ZlpBdUZjMFBzaG5v?=
 =?iso-2022-jp?B?K2gycno1ZWVzbkI5RDBKZjJianI4VXRRQzhBelQ3SkR1MGhTNllvU1FY?=
 =?iso-2022-jp?B?V3ovS2NqWmF2NFdWeWxKeUIxWlo5ODdZM0diaUMyUVNRZTR4R1JSbWZo?=
 =?iso-2022-jp?B?bWVtZnJ2aGxoT2laQmF5S0VIV3hNcnhnUDV0RU9jNUN6d2dFbjhNNmFJ?=
 =?iso-2022-jp?B?TzQzeHllVTNJak5pRHpmUDQxQjB0WlBlQXYyQ3g3R2VwU21zWVZyREJH?=
 =?iso-2022-jp?B?VmJmRDRYU2duN29VQVo4d2c0Zk16dlVoemNQSXQrb2FHVGJkNG8rMlFr?=
 =?iso-2022-jp?B?aTlwUTMzNll1cWpOMXZxbVNtc0p6UVhaZmd3ZXA0by9SMEZRVk1jQTlJ?=
 =?iso-2022-jp?B?anFqSm5YTDhHbnR6RzVFTmlqNmZTMHpYT1FXRXU2M3NOSHNYRG1wWm9n?=
 =?iso-2022-jp?B?QjJPelFjTmVqZk0wcXhONUNWZHNXTzdWdEtycHc1SEtVN0hSVlNGZXFW?=
 =?iso-2022-jp?B?L01LTnhLdlFZdXNTODRORWFPdmlGSjJwZERoWjhmckdEN1lWeEFaNmJk?=
 =?iso-2022-jp?B?MkFUYWVYNXNMdEdzK09xN3hmeFFLd2RCVXRrem1FWURBUlhFNmVRd1ls?=
 =?iso-2022-jp?B?NWZHa1FuaE54OVY4WlI1UFV3S3hGWTNrdExMNHZlVU1iTVVuUmpsQ0pl?=
 =?iso-2022-jp?B?dDdiS3pHYzZuTU1yd3R6b28yTmxMQkJyaEN3WkZVTEdjdWRzVGxRMFNm?=
 =?iso-2022-jp?B?OHFXL0haWnpkL25iSEwvNmZNTzNyZEVUVkNiVmlVcjF5YWREY1BvOUl6?=
 =?iso-2022-jp?B?YjA5UzdSMEs2NEsvRCtIQ1FPeGdRWXZUK2tvd3lLbnozUkhJS3BpNEdI?=
 =?iso-2022-jp?B?YklEdzdISVJpZCtwOGlrclFYUFBwTUM1R0dhZktmaUNyZlBTZGI3OG9n?=
 =?iso-2022-jp?B?QTJBS0JoZzBpTU1ZQTM0czR5d1BEamVsOWZMSGt4bmpGdE1vTFRZank0?=
 =?iso-2022-jp?B?V3ozQTE3Q2wzdC9qNzlTSk9tcWQyNXJWRjdwNVh2czBmRE5ZZlFnaWZU?=
 =?iso-2022-jp?B?VlBUelZqd2tCSVdZUkxZWXJabVRXOXZEMEFwMU9DWk9RUklyZ1lPaVNY?=
 =?iso-2022-jp?B?YlBsdWFMOGJwTnVweklVTXpzbXpyTFNNMVpWc0ZMMEtBeFNzZTl4Nkpv?=
 =?iso-2022-jp?B?R1ZrNGEyeVNtWUJ0Zy9yeFowcitMZjFGNnNWQW5yM3ExdVdGUkw3SUxZ?=
 =?iso-2022-jp?B?d09Qa1BHTHVCZ0JveG1KWXl2K1drVDRWT2laWW5LZ1RLMDdtVm5jM0I2?=
 =?iso-2022-jp?B?YlJrOHdtWUpIdHBaWTdmNkhlNXBHazRyTStHMDhmeExRN0NUZEtIejF2?=
 =?iso-2022-jp?B?bHZlaDZzNVRsejQ5TjF0ZGJRb2k5WmNVOFhyWEVTU1VDSHBja3BMTnMw?=
 =?iso-2022-jp?B?bTV1aWM9?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6bd66ae-2f0d-465f-cbc6-08db237b3610
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 04:27:09.6983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G3iFAanxcA2EDKlMePbCF4FFyzyDy3wIr6G+gleSt/ORoRDbgInOLAu1m8gp9h8JH4yoz/6XlDG4ygvvYCp5lVccyazqjElYI84+9ad5JOS6Y0c4I/FoFkxzCd7ARoO2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB12016
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Mar 2023 04:27:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10991

Hi,

CIP kernel team has released Linux kernel v4.19.276-cip93 and v5.10.173-cip=
28 The linux-4.19.y-cip tree has been updated base version from v4.19.273 t=
o v4.19.276, and linux-5.10.y-cip tree has been updated base version from v=
5.10.168 to v5.10.173.

You can get this release via the git tree at:

  v4.19.276-cip93:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      849e6920f9039d78588d7ab644573c58cca7e64e
    Fixed CVEs:
      CVE-2023-1079: Use-After-Free in asus_kbd_backlight_set()
      CVE-2023-1118: kernel: use-after-free in drivers/media/rc/ene_ir.c du=
e to race condition
      CVE-2022-3707: Double-free in split_2MB_gtt_entry when function intel=
_gvt_dma_map_guest_page failed
    added commits:
      CIP: Bump version suffix to -cip93 after merge from stable

  v5.10.173-cip28:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      2988848bfa1d1f2c02318f2193b06874fb5f62eb
    Fixed CVEs:
      CVE-2023-1079: Use-After-Free in asus_kbd_backlight_set()
      CVE-2023-1076: tap: tap_open(): correctly initialize socket uid
      CVE-2023-1118: kernel: use-after-free in drivers/media/rc/ene_ir.c du=
e to race condition
      CVE-2023-1077: sched/rt: pick_next_rt_entity(): check list_entry
      CVE-2023-23004: malidp: Fix NULL vs IS_ERR() checking
      CVE-2023-25012: HID: bigben_remove: manually unregister leds
      CVE-2023-22998: drm/virtio: Fix NULL vs IS_ERR checking in virtio_gpu=
_object_shmem_init
      CVE-2022-3707: Double-free in split_2MB_gtt_entry when function intel=
_gvt_dma_map_guest_page failed
      CVE-2022-2196: KVM: VMX: Execute IBPB on emulated VM-exit when guest =
has IBRS
      CVE-2023-26545: net: mpls: fix stale pointer if allocation fails duri=
ng device rename
    added commits:
      CIP: Bump version suffix to -cip28 after merge from stable

Best regards,
   Nobuhiro


