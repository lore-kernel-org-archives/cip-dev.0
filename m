Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B25C28B30
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 19:48:05 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.1])
 by mx.groups.io with SMTP id smtpd.web10.4090.1742500083396182056
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Mar 2025 12:48:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=JxxubFgj;
 spf=pass (domain: renesas.com, ip: 40.107.74.1, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V31E6QKQvoBSQPD9CowOH6OvHsPX/bN2A1nZCZ+LmQWlr0MlW5IQZUIpoFCbWPHsaic32onYLpqxbt06VyMACOUfKeXeMKkTtoVtx0CQ3sgt0FZTinjYk+BtcbTdJfXxfKI0cpGF1jj0ycl2ovHOmr3qwrFNPxu52ePwKqU6tIQ63P1gT11D9ZR5lRys5uMaOGOwdN+S/a82YQW4s8gGyK8s6YxvvmKnohP1Hj0qpv9q3UGfC390NAQsdgfA5at/kg541TlbOSK15JmRI1N9Yh9uzZElgCNGXmuYHYDj1F8eTr0MjJiXeTbgA3igi8He0sVfRgaxVnwFe2PiqwXCGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRbQ5gw23034sdA9u4kC1uc1JqGZXLCag4NRfNNIywQ=;
 b=ggSqLSzENlaKwCD0rMWjTqiuGbujqJUDuy7cv47geZsGDJZzhiN2627zbceBG6zLPWH5sJhs+TjxOkvEB5a9A+mf32xdA3d4v5kZmAmmveRxQyqqmq+6RzKE7RpbgIIkshAlw4tuTf1WPtgWY9fRXi2A+MymAy6x7v2y5nRAaxa4vHzUvZ78u+fUIl3JQTZD2pGFAA85CFQdWoLNBwJcTeGI/VZGq0x+rK9pswOlf2ZVV88pMUL7dCme/PQafpMvRYGlyeF3z76A1IeGXahzxMuRZj64FZQtnf09uXzd/NqcgonMUGMTo1eyXK0SHiexoEBVxXIkU39sNRFEW+6/Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRbQ5gw23034sdA9u4kC1uc1JqGZXLCag4NRfNNIywQ=;
 b=JxxubFgjJetd4nRcF9pvz3Rq+AnX5CW+msUwGJPAHJI6ATqQcgNB/ApjxvAo6xB98pS/9/Tkw2DlEjc/fhS7PjKD7kakFEp2Dy1dZ78xDZmSqtuzH7m6/kz0Rl4xN4JZpUkxbshrMzy3nUSkgqW5fXJtzJhnz3h5ytGOdLt+xsU=
Received: from OS3PR01MB5896.jpnprd01.prod.outlook.com (2603:1096:604:c6::8)
 by OS9PR01MB15873.jpnprd01.prod.outlook.com (2603:1096:604:3d7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 19:47:58 +0000
Received: from OS3PR01MB5896.jpnprd01.prod.outlook.com
 ([fe80::1b62:57c6:c2cf:641b]) by OS3PR01MB5896.jpnprd01.prod.outlook.com
 ([fe80::1b62:57c6:c2cf:641b%5]) with mapi id 15.20.8534.031; Thu, 20 Mar 2025
 19:47:56 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>
Subject: RE: [cip-dev] Starting 6.12-cip branch
Thread-Topic: [cip-dev] Starting 6.12-cip branch
Thread-Index: AQHbmYnFh8702hUy7k6dr3rLiCahALN8a3Cg
Date: Thu, 20 Mar 2025 19:47:56 +0000
Message-ID: 
 <OS3PR01MB5896A5F20C13F5E62925E2DAB7D82@OS3PR01MB5896.jpnprd01.prod.outlook.com>
References: <Z9v5aLZhun8zwFk2@duo.ucw.cz>
In-Reply-To: <Z9v5aLZhun8zwFk2@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB5896:EE_|OS9PR01MB15873:EE_
x-ms-office365-filtering-correlation-id: f074b1b7-ca41-455c-da36-08dd67e81cb3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?Windows-1252?Q?WfM3bQoJhsAuowNJfYukvNx6gZJznMm7kbgN0he53XKhPkdU/S77Cu2u?=
 =?Windows-1252?Q?XX/pDbUO4oeNHV0h5CKSJqDBC2D+fnDDu5tasSLVYBd1LiIU2sCv+7u+?=
 =?Windows-1252?Q?bqMbEzro6BmfbPEkkXmzZZcxob/UeWeiIzyDyEiTIXoCTkv30bA1bI0a?=
 =?Windows-1252?Q?BKvVw1DKCbTPwJuUy+wkeEqk89yM2gqH1OjMkWgt1sobtuqcefPVu4uF?=
 =?Windows-1252?Q?qf/24eJQpXLwsU79J/A3DAJmzbQZT8xoYmwo9iYqYN4CypPCf4KlVEED?=
 =?Windows-1252?Q?vjmQsh/u8ATJcl3E3cpYZEto17I7LJCRW6hHbdU6BHbcwCiykgrrIQho?=
 =?Windows-1252?Q?Ui4YgiarwwLICiKrGKerUfEBqzRj90cacbPF4JUxpvI0xApQ4MJYdGvn?=
 =?Windows-1252?Q?1oa7AS3c53DHULPByW7fHHYJaSTtqDC54yqFw31E0x336I79MPBNve6a?=
 =?Windows-1252?Q?/K2KZa0cofmD2w8zlDxiy5+7kNFaJ5EcELGQ1Zu/zXVciEMbMk/ZOOax?=
 =?Windows-1252?Q?qHBY7uZJgFuEy2n1tCG8U/Bix7PqQO4Yd/HIRB4ZxyQR1eEzVuHbsu98?=
 =?Windows-1252?Q?GoqsIxjpA7HZ4LG6Kcdd2JQdAuChl2cc+0IWL7/IIpQMb9vjMFuHRz0W?=
 =?Windows-1252?Q?z6ui/MQ0l5GDxCiJKz7FSFscHGRiTPl09Ajtjlo5yeQDGaTTzQW9oQnE?=
 =?Windows-1252?Q?BNMzl+JLDspHmzc7z9l6ce6Ev2T6TIPqH25S2XV8f1RTHj1KrEHH1zM2?=
 =?Windows-1252?Q?VySUGFv01rZQXVR34kyfbQ5/20luBVvyhmA4UFFmODSQaIUmeIj6MLCQ?=
 =?Windows-1252?Q?WYIyv3+fV0NpkroOrzQKsH7BO6tYl0ReJnN9Yi6XdxM35/gDEIFtmxXd?=
 =?Windows-1252?Q?OjStdDRtlfaOlKbuhDIVXs/86BZa32mK+QjLFQH1MuPUULnPxAkKuFxH?=
 =?Windows-1252?Q?GejjVrkHx5THeuw7xWUieJPD1NTbfqEiuY0SIjhQeO12kUUp8KvoWLCc?=
 =?Windows-1252?Q?Rz7ngO3TXLSxBKYkjY//j3Pciu0/lmZ93EMO2PBxbg/cao5cpDnn3NmI?=
 =?Windows-1252?Q?Okf1TfS332BLHtd+KLc/ThU5FogxrRJhLGTj97R2yQnHXoT1fCGhPDWX?=
 =?Windows-1252?Q?xAQPcxGt/umM7m4DDtjyaym1C00X0hxLegWUSEMeq26kRibuKKQ1aGEs?=
 =?Windows-1252?Q?TB8IbpYuvAhZFSDr5zOUN5dVJAefobJo5ysb48okshSBtS37aSyHkSqf?=
 =?Windows-1252?Q?WMW7pPa/tBJQYtwCt0aie+8cs6qTIhY+yCayjhop1foGNEOc4VxIwFKq?=
 =?Windows-1252?Q?scuJPLq9xd3twxpVlRKRffuSL2iCZ0cQadbTB+KIRfenalC+N96L9RfA?=
 =?Windows-1252?Q?inUHLrF/CRLhtPbMYtCq2PFmuyivgmj5zHKkqNVFtcLPofKWI4QqZHmF?=
 =?Windows-1252?Q?WauWZpmjTbDGjEPSBF0rGeCh1uYX3P9vYv49EwZ9KjDrMzZLkrK0zOZe?=
 =?Windows-1252?Q?jr0mYQEO?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB5896.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?v2Dpa4d/b9ySd7JQLIq43b23xdaCAaxVQvuZazzBgKcIptut8QDqmuB0?=
 =?Windows-1252?Q?nVKUYQeNEFQDd+c8aBg5RtVbHnLESwpdgW+52OHLY6kq8TFsCpJRSvcf?=
 =?Windows-1252?Q?LuMKqaifIDGXHKExq270iCU6lADKZhjbds94NRkCj2RFnYWrcRuI2H+2?=
 =?Windows-1252?Q?0e7rvfJOxjVGf8I3lbmQ5ZdQENDUwmDs9tSXEecScFn9hqicJS799BOz?=
 =?Windows-1252?Q?2T050fZk7kLK97Q7GVocNW/c2zMZToznRi7rIft/CzY/ZsNe7aWjpFU7?=
 =?Windows-1252?Q?OQdE8tH9A7vW2+mpb+L2xVz3xCi6frwGCB2vDnXSZpz+rOe1h/XCS5zt?=
 =?Windows-1252?Q?RGj4DOHLGJzq9BOst7YB/xODlKJy/qx0buYANMnVwhKzqtoTQFuFhdtG?=
 =?Windows-1252?Q?sFTSlYVRE8jVuppBj6rpYheAhspPy0/Jhil2r0JzYBK5B3w1RFSbRgKM?=
 =?Windows-1252?Q?NZ12Q5OPmyqr+wkFsp5qkDx53Mf4vW+Jd9iIRGRCAKnFh9rpWsBwxPRX?=
 =?Windows-1252?Q?pfTmfsp9FKYHUKpkbTiajxuaEyAH5X9sU6EVfe4eFB667wYTKuN/indo?=
 =?Windows-1252?Q?TP0HNOnWif4VT6mgIbtWoc4v2lLwKRqmqjFeQK+Uao043Y4LA2tUeFjr?=
 =?Windows-1252?Q?gEuRArzipbsSJQ9J4vK0H8ReB42Xrda4S+Q511UInFoBK/iP+hIj1gGn?=
 =?Windows-1252?Q?8ocoXfAJ83Lat6vTbv8YBKakV3RQhPHumBFfLrm8eDm2i+h6Sldvz1k9?=
 =?Windows-1252?Q?s36y/njSVNg2nsFkMe1WRCPSKYycW+ffhWYVzmW85Z4LOUPHAPLYcqA9?=
 =?Windows-1252?Q?lN1aqczVdyFauciDpJt1f2nnBKCIr+dJvsi3vO7HKywXlnWPVDbw99Am?=
 =?Windows-1252?Q?BixCFXXLlDzrjc+Z3HuexpptPrXFVpiC/E1f1YQIpVqzwqpCvtw8+XRX?=
 =?Windows-1252?Q?YlVGpTEtwStO3HUQq/qmQsM/P1vAK4fr5/g7UVTSqcWRMXQqiP0wna/R?=
 =?Windows-1252?Q?PAIjR6ovBMpn9wLmvc5/C2DMSg/EjYwLU1uMBnMxfiswDUxL4DCuIQ4E?=
 =?Windows-1252?Q?EreNpIjrKtgHib/xdRn1D5smACjMhRyx6Tzh61FWvjL1iYB2EjvGD2RJ?=
 =?Windows-1252?Q?WY8UXS5bgLm7O+OEYNSOgs1qGxlCyHitc1oaT906jkE9ba2z70mNQgpt?=
 =?Windows-1252?Q?ywZH+iJy72tFlBuIRqIH6UIxr9p3+eQApSsVTW4q41tTME8QmThInDFJ?=
 =?Windows-1252?Q?rdhia+iTBzXoKpYU/kCEPR80pJozBZ54gswZWJA0ZL4S4yd7ReyxIBnL?=
 =?Windows-1252?Q?K+2UgCOs7b6XbfptdJK28nmlWSrOljB4PqsuPlNYH2ERuS67u40v3Lgh?=
 =?Windows-1252?Q?+bvN2K8Bh4SIi+++TDYYvdGOhQZd89JXtS76n0kCWncXLsiwHrNO5Xnc?=
 =?Windows-1252?Q?yLvzcSK5tc66GA01lWWC7uJLWD3G2dZRQ/9jDNAFHZ06tM+lkch6lKlu?=
 =?Windows-1252?Q?iD039FMqTUwQHOsDUabiSRswul4c059/7882VmjjVnzupsGhEAUmlr41?=
 =?Windows-1252?Q?9ZdCb7bb1h/ej/VSO0CMa/mAd356yZU267A+MWUrcYDkoB10jzFX0tiS?=
 =?Windows-1252?Q?L476/Nc5vZefrLzQWbhrpO+321HogoBV/vLuU/mm/+M8FLb7e19y+uFR?=
 =?Windows-1252?Q?qBupll8thW1MjD+DVE/PUafaaIEo3UeHb8kzymqNLGd+tN2coCFv6w?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB5896.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f074b1b7-ca41-455c-da36-08dd67e81cb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 19:47:56.7719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KXu9X2JIY1Gg8B6uoUP/MYET8Pce2PWqqlzK/ZIDKggTbDdDvF0MGR/fABJiY/fOnCZw0EK7WXzIb+y7mnporgbujeEB9sGG6PvKK7GvBnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB15873
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Mar 2025 19:48:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18301

Hi Pavel,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: 20 March 2025 11:18
>=20
> Hi!
>=20
> So... I'm starting 6.12-cip branch. It is based on 6.12.19 and I
> already pushed tree to kernel.org:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-
> cip.git/log/?h=3Dlinux-6.12.y-cip
>=20
> Next steps should be starting testing the branch. Chris, could you
> suggest appropriate gitlab-ci file? [Or even better, could we test the
> branch without the gitlab-ci file, as we are doing for stable trees?]

This should _mostly_ work for now as we don't have a localversion file yet.
Once we have our usual CIP localversion file we'll need to have the relevan=
t directory added to cip-kernel-configs.

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
new file mode 100644
index 000000000000..e5e0e4872101
--- /dev/null
+++ b/.gitlab-ci.yml
@@ -0,0 +1,3 @@
+include:
+  - https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/raw/mas=
ter/linux-cip-pipeline.yml
+  - https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/raw/mas=
ter/trees/linux-6.12.y-cip.yml

I had an experiment with GitLab including the "tree" configuration above de=
pendent on the branch name, but it wasn't playing ball.
For now, I suggest we just stick with the current approach and drop the .gi=
tlab-ci.yml file down the line when we stop using it.=20

Kind regards, Chris

>=20
> This error will need to be investigated:
>=20
> fatal: Not a valid commit name be20a73e03e19005cfa5c1c4d6158af1ba02f056
>=20
> These commits will need to be ported from 6.1-rebase branch:
>=20
> Collecting commits
> Parsing commits
> Checking commits not in v6.12
> 2 546875ccba938ba4f7b5c616a1a1e334c5f2903f
> a63fe5138f27d91f850abb52f6a0df37991b1e3e net: ravb: Add VLAN checksum
> support
> 3 85c171509821af048a45b435e0fac36edba6a0cb
> a993245cf3ad5d1164a71475eec17fd51e28201f net: ravb: Enable IPv6 TX
> checksum offload for GbEth
> 4 59cceae40c67d943687587912483d68226cd04de
> e7b69b28560bb977a05ab6ff280769b5a2ec1ee4 net: ravb: Enable IPv6 RX
> checksum offloading for GbEth
> 5 e63b5fd02a00aab8e79691359e931dafcd9dfd05
> e8486d788dab19ddc25358196c4859e3dda4456a net: ravb: Simplify UDP TX
> checksum offload
> 6 4574ba5b711d7f7968c116521ef58d46fd4f89b1
> c28d544f32b95153155c94fb7411f2d6fa14bcd1 net: ravb: Disable IP header TX
> checksum offloading
> 7 faacdbba01802c89f7043f9a47ad442c1195d307
> a7548baf2b4f58b75292cddd35830a230c77f9dd net: ravb: Simplify types in RX
> csum validation
> 8 5a2d973e36061cbf8d1ba00a9294244522715e53
> 15053ac983ab9fc781aeaa006c7c8b817b0bbb03 net: ravb: Combine if conditions
> in RX csum validation
> 9 8d2109c1a51525c3586c5bf6f78ab1ce3c2908f8
> a1bdc025b634187d6d7cc462c5839ece8e102934 net: ravb: Drop IP protocol chec=
k
> from RX csum verification
> 10 c4e347a02b14fa2425337473fcb120c62936cbc5
> ac242a57ad28de613c61b76cb82b7d30a0e70e37 net: ravb: Disable IP header RX
> checksum offloading
> 11 8e3037924a36505531999df8f5847a68b9272c41
> c3aef62f4dd2ce3fe35d45fdc5cfdebc02b22285 net: ravb: Factor out checksum
> offload enable bits
> 16 c520bbb523304ba98de9ffeeb0ef289921434125
> aefdfb4c1c3ff4503caad2c357cab0fc4b910aea arm64: defconfig: Enable VBATTB
> clock and Renesas RTCA-3
> 17 0cd647cd53db0315361e41056e10739a5ee1e668
> 8d96cc36644ab5500f9b48f2f51d9473d77d29af arm64: dts: renesas: rzg3s-smarc=
-
> som: Enable RTC
> 18 2d768aee9f5294d2023e824c0906e2e7d1414629
> 8b8fef2d3115f20327438e7aae01cb80b0f87ff0 arm64: dts: renesas: r9a08g045:
> Add RTC node
> 19 ac948eb8ead1265ff034955bdbbb081744f1e7ed
> 011c639f99a749cbfc5256f91a5e6b0dc0c7835a arm64: dts: renesas: rzg3s-smarc=
-
> som: Enable VBATTB
> 20 23c44956bce5aa79c060fc3e5d51843735e6eda6
> b3c797ba7dfe077b81bd521ef94574238f2982e1 arm64: dts: renesas: r9a08g045:
> Add VBATTB node
> 21 8f315a5c7376b2bc324d62a8400184da77f25e28
> d0207ac40f9b01a737a657f19f66294acc70d8aa rtc: renesas-rtca3: Fix
> compilation error on RISC-V
> 22 d4488377609e36cd9785533c29ccea4b86c292b9
> 541924b0a8c2a69974ced3cc9d56d2f4fd056fac rtc: renesas-rtca3: Add driver
> for RTCA-3 available on Renesas RZ/G3S SoC
> 23 71c61a45c951eca67dd2cbc4de9cdd687ece4ead
> e8e3acfa534f32c5d1afc1255ceca88577afa172 dt-bindings: rtc: renesas,rzg3s-
> rtc: Document the Renesas RTCA-3 IP
> 24 be20a73e03e19005cfa5c1c4d6158af1ba02f056
> db7542114675a85d50f8b41b9cf342df7d0a7bf6 clk: renesas: vbattb: Add VBATTB
> clock driver
> 25 cdfd5daf90af8363fb1f58e08c829a775b2e2fc5
> d7ae15b36472510c35f08d5c457e1525fff0d960 dt-bindings: clock:
> renesas,r9a08g045-vbattb: Document VBATTB
> 27 e1ef630c56d36770e180f0d0bf7b61b5289f5c48
> 916eedaa995f67df0b205119649849ea5de83055 clk: Add
> devm_clk_hw_register_gate_parent_hw()
> 34 bad201b2ac4e238c6d4b6966a220240e3861640c
> 8222bfe0e3fe1ffc98a6d8a8e49284b3bb2c3dad watchdog: rzg2l_wdt: Power on th=
e
> watchdog domain in the restart handler
> 45 91dcdfbc5b770d4501b1a30d087affc9ed4fa6e5
> f6e00b23d92b4cac35a5fcfa654fef1c4d999dd5 arm64: dts: renesas:
> rz{g2l,g2lc}-smarc-som: Update partition table for spi-nor flash
> 47 c0f2ec5683160a8604292516de9bb6edc7073226
> 32f0604028a5cd99f6de6cc3f10dd1040b50c6dd arm64: dts: renesas: rzg2ul-
> smarc-som: Enable serial NOR flash
> 151 None 8315d48bdab555e103b02a0a76319cdb351e23c0 Revert "arm64: dts:
> renesas: rzg2l: Add missing cache-level properties"
> 517 None b99f83040dd996d328c7eed0d39c5bcc3ba7c23e Add configuration for
> gitlab-ci.
>=20
> And these will need to be forward-ported from 6.1 branch:
>=20
> Collecting commits
> Parsing commits
> Checking commits not in v6.12
> 1 651dee03696e1dfde6d9a7e8664bbdcd9a10ea7f
> d08cad4e6b100c19001d46f85ce913526ddd767f serial: sh-sci: Increment the
> runtime usage counter for the earlycon device
> 2 5f1017069933489add0c08659673443c9905659e
> ea067d976d8b26f4c29c0d626b0ea371cd4ce19c serial: sh-sci: Clean
> sci_ports[0] after at earlycon exit
> 3 239f11209e5f282e16f5241b99256e25dd0614b6
> e526ac9a17969360c770da3f2ebae4b7cf2cfd86 serial: sh-sci: Move runtime PM
> enable to sci_probe_single()
> 4 7cc0e0a43a91052477c2921f924a37d9c3891f0c
> c7e0eea97bbea76d715b9747ab93b22636a90e30 serial: sh-sci: Check if TX data
> was written to device in .tx_empty()
> 5 c1117a2fefbcce30cced3a180585e0adebc0fa89
> 6947ffd86dafa874e841b5a25786d49ea22cf662 serial: sh-sci: Use plain struct
> copy in early_console_setup()
> 8 d828c6726fe5642d1c71e9edbc4799c959b471cf
> c2bc4adb340a59dc45e2d328692ff49f609cc9b6 dt-bindings: serial: renesas:
> Document RZ/G3E (r9a09g047) scif
> 13 None 8da62141b20bae3e0cfb12c3537d530d14f02441 CIP: Bump version suffix
> to -cip38 after merge from stable
> 14 None f5afe3636e64ff166f857c71488e7de41c1f0e7c Merge tag 'v6.1.129'
> into linux-6.1.y-cip
>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

