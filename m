Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544F2C54EE9
	for <webhook@archiver.kernel.org>; Tue, 20 Sep 2022 10:13:47 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web12.9961.1663668823422867055
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Sep 2022 03:13:44 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.155,
 mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 28KADeQp006368;
 Tue, 20 Sep 2022 19:13:40 +0900
X-Iguazu-Qid: 34tMQIIQy0W1Tdep1k
X-Iguazu-QSIG: v=2; s=0; t=1663668819; q=34tMQIIQy0W1Tdep1k;
 m=vkRudk1cBZeXE7rF9oE556bt/NnTBS41f+jC8ofLhY4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1511) id 28KADc2W015613
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 20 Sep 2022 19:13:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axi1CKaSC3IGgsyEoGWEiGN8PTX2RCJuMsO33P40U7hYQRMZNrl8eCRwyiizbGzB5teG0Is5dG02MsOesnvVtJF3ETCX5aoUNZJPKZjk4P82MXNxsCPbMwQboU305LrxTYl2GHf3UKlSk5raanHh1TFZ1L3+KBIN5Rs5kP4DejIMG+Btquu2jgxd+t0DSQ4XY0KxE1q7ZAf9kRcZUWMj+TosOo5VciyJHJY/osGXHIw9SBc0LDSt0kJnqd0SnFhlUIwN8o8OWdcrD8YAvW4tdMGmTg90DQeKqDidSABehqG93Qt88KRDma5hsZyJad6Ew7mI9tjXTvy9tmcLIc8lKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCjmBHECM6QJ7FBxwMaVC3YyMGRzL65/eFMFVNWoEtg=;
 b=gfG9UI5OqYgIstbETw4Qb1pQKUC7zZP6qjvTQxef3uRYR4IU/NAlwAl/X8h+Xf2J19yDKlJKIfHFzQeLp+Hin4J5goPHm3/5BoTOgWFC0qisDommvI89fD914E7d9G5Iz/uoXAZDsNvHG6PLFNadip3d5z8INpBWs6f6fjykSIHhIHlQpKEl9R9+k+SVh06H6n8sgVfJl2bP8OZU6cxFmJezgxce0rqbFMRzVF3sbt2+AYiBMsLnOnJHWu1lCHio20pGP6HFu+l6FtY9YdQx9WxnbLlJeoCf319h638STnsySwH6mt0RrnYPKND6QBXCrb3Kl1EH2bUqyU/udwC0uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [isar-cip-core v2] README.swupdate.md: Add steps to verify
 SWUpdate on BBB
Thread-Topic: [isar-cip-core v2] README.swupdate.md: Add steps to verify
 SWUpdate on BBB
Thread-Index: AQHYycK7LmHFWNafNEalxQ0yB0dsO63oHukA
Date: Tue, 20 Sep 2022 10:13:36 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6147E0D24508D1048B9126A6C74C9@OS0PR01MB6147.jpnprd01.prod.outlook.com>
References: <d98e57e9-2219-6e09-582c-b465e9295193@siemens.com>
 <20220916114330.18443-1-Shivanand.Kunijadar@toshiba-tsip.com>
In-Reply-To: <20220916114330.18443-1-Shivanand.Kunijadar@toshiba-tsip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6147:EE_|TYWPR01MB9592:EE_
x-ms-office365-filtering-correlation-id: 6d114573-73b9-4844-1ec5-08da9af0c814
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 liNvh6bmFA6SMRNkEu1ISzAyL5h1zhMPtQF0ZFCcHLiUG6Kwy/aSZuK2N6ic1vdyC9E1XypxOR9wUEU7XeZpKUZjGgqI2WKhebUDVuNR2TK2MG6A+PO2UEqkxpU80Xj2hZ8MOkKdPQxrXBxiNSbpYng1zPNQ8vWNn7fAEFbqeOBpTDuaTWMLzMsXW1DiMDSWuhGy4YhCLuh33M2lFSscwuTztex4LN3x/LqpWBnzD27zszQeCkbAg6QnIf2oV78o9wGa/tlfMIYQ+SkIv9JIIhW4o/C5/CPOTHPfc+9bIVuD3oNmMwTG34ToZDRKdtpEyQJbYCo0f+Wx/NR06b0oSEwZlRCrPn3dTbchhUGtJbdpYY9dFvr6yt5oAaq/yHDavB1jZd+W6w1d8snjVi7fZYzaOdRZ+KvHR+YHsmdy1DRQj3mf+VJQ41IdPF7rzjdG3rfDZSjLEsRzBAxuPyYNbgxhZGzF3zG5D9RhMp3bIuRnVgCbmZucnO52NGIk7gnftiVKYr+7sPQ+yODwk4zn1ZwermZDrnphIkv7zvkgoioTR4nMoZ6amwg2AzMzD1JB+4AP2Uebdfi1/Kxaul6eftmC/LWW9Zp5pgn/MUt23rCKxKt8OTnMHZ50iIIdUvjc8zQkEzC7NdNYbDa2rRvLMYQx1m5sTOzwTGUnZ+5TKLcp0z/I9iQrreZH+rUwEzSH/jd8EBh8ACXS8yZ/DO1T0lR8ITDp3bIsucEMmlfnepRUTz5HRJbpzmmS391svqO7X/gAJ4CDj8iYxc37E8lwmA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6147.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199015)(6506007)(66446008)(64756008)(122000001)(66476007)(33656002)(86362001)(38100700002)(478600001)(38070700005)(15650500001)(2906002)(5660300002)(66556008)(76116006)(4326008)(66946007)(110136005)(8936002)(8676002)(54906003)(52536014)(316002)(83380400001)(55016003)(71200400001)(41300700001)(186003)(107886003)(7696005)(9686003)(26005)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?QURMTjIvN0VNYXErM0RHZ1BYMFlkUW9QZFpGbzlaVlBhWWRpYTIydEd2?=
 =?iso-2022-jp?B?MzJNYkJDSTdFT1EzOU03L1Z4QTVPVDcwTlRkbHIvMUYrOXE1ZU1GUzI0?=
 =?iso-2022-jp?B?VXRsL0N4MWUyd3dhODVBYlY1c2t6ZVVRK0plWW50TGx2am1SSkdobkhB?=
 =?iso-2022-jp?B?S2hLb1p6cnVMSlQ1UHpod29qMndVQ0tjVXFrSlI0Qm1YNzFkOVB5a0hR?=
 =?iso-2022-jp?B?UjZXOUNrMWNZZ29LK0paZkwyOXY4K2JwU2RHNWdDNzh1QkRidE9mUko1?=
 =?iso-2022-jp?B?b2ZMZjN2ZWhJVDcySklPR24vMW5NYThFQk9HYmgxYmxZYU1kUjNCSFEz?=
 =?iso-2022-jp?B?dWhDQkFrR0pKRWl2M205YXZqREU3YXBRbjFaREI1bDk2SUJhSXd2R2x6?=
 =?iso-2022-jp?B?SGFRcEN0eVFPOFhoWEsvNTYvTlo4cFUvQ2V3UlYxelREY3VEUXlxRExH?=
 =?iso-2022-jp?B?ZUgycmQyVGhWUGJUMmx1QUxXWmpYcElvbE5FU0FKSzZSRG9ONTFuWjk2?=
 =?iso-2022-jp?B?OUUrQkJ4dmVTWi9udG8rdVprdUF4R3JnM0JSaWpQaGxoWjFhdWdKQkQy?=
 =?iso-2022-jp?B?dXAxbnhmeis1RlpkL3Q3MUhsQ2FWQWVha3MramhEVUdaRkd1NDhHSkcz?=
 =?iso-2022-jp?B?eTFJMTBKTEdtbGRtWU5Hb2F0c3d1aTliOXNJZTlyWnNHNDkzTUJvSkRj?=
 =?iso-2022-jp?B?Q3ZnV2lqeTBkNmR6YXR3YkpvZGUzOENhSzUwMGFmR2NDN2JKdDJIckF2?=
 =?iso-2022-jp?B?N3ZRVE9aaHh4VldRN0hoNDgyUjJBcjVVWW5hN1lpeDFtSG11Y3hJN2xs?=
 =?iso-2022-jp?B?d3R2RkNWSkZ6eWRsMnBnbUE0dDFNUkhwazBaRnJmd2RIQXpVRDl5Rk95?=
 =?iso-2022-jp?B?MVpySTlOcDg1dnhMSFZoZ0ZwVWFZalcrRHN0VmxZRE95Q2V6MEZTbGlC?=
 =?iso-2022-jp?B?T05EV0dJajNtQ0VCbHpNbTIvUW9KSEhQSDJnWTdYVk1ENGlPd1ovaWk5?=
 =?iso-2022-jp?B?THVJUWN4S3lxKzM1MWpzdTV5a0xoWmhZejd6WEVzSy9wNVJDcHpjZ1Vw?=
 =?iso-2022-jp?B?dXI0OFpWOWN3VERhMkUyV3FQNXc0QUVlRUdvd3RUWktRYW1VTVRoZjRs?=
 =?iso-2022-jp?B?ZkhqUS9lUTQ5MkN6Q252a1NaeXFlNFBUVWY2dHZyS2IzWTZUaW9MZTFH?=
 =?iso-2022-jp?B?RVBuTlBPc0hibmg3M0N4SUlsdnR3cmVhTHhCYWZwZEdnb0FJdnc2MnNJ?=
 =?iso-2022-jp?B?VVd2TE1FcjVyYmtPQ3IvV3h3bDRCajkyV0NBejBLa0RKR0R6cmU4WEs5?=
 =?iso-2022-jp?B?Uk9iTkxPS2drdndUMFpEcjB5TkdOUzJQNUd0K0phUGVzUGJnOHNpS05O?=
 =?iso-2022-jp?B?SFZPWGlvQU5MWEk5SnRETUEwamRSYURmcDBBVWlpaVlGcHVCejVGRXc1?=
 =?iso-2022-jp?B?OWlYNndWRDlrMnlWdDdrNXZjVGNyMnl2T2lXWGVJUjNDTDVVcnZpSzJU?=
 =?iso-2022-jp?B?VEtHa256VXZLUngyMW5LVlA1ZlovL2JZOU4wNmFYQWJVdjlZQzlNc05H?=
 =?iso-2022-jp?B?b2lIK3pIWVY0OXJmV3NNckxKL3ZSVWJaNWJ3dm9GL0cxQ1Y3UmpmSS93?=
 =?iso-2022-jp?B?OWlWNmQrLzFYUEcvSTNwOEg4RkcvVVU0ZDdaNHNFUDdFcXMvYnpWMFoy?=
 =?iso-2022-jp?B?dzRYV0xOSU9lc1NjdExvZ3FiV0c4aHZ1K3FTWnVwV2R5dEVnRW1wS1lY?=
 =?iso-2022-jp?B?aUJXMm9GWGErL0Jpd3R6cU5JbkZDTUo2Q3o2SzUxU2pab0RJUThMOEUw?=
 =?iso-2022-jp?B?QjRKNFZzbGFocFc3eUp1WDdidWg5ZllsTG5ESTk2Y1JtQW8vU3BJUExk?=
 =?iso-2022-jp?B?NERFUlBMcW15V2FrZG9rWGl1SFRFeW4yWE9mbk44eHVzL1BRRjc0cC9E?=
 =?iso-2022-jp?B?RDQ1V3ZaTU5MVDliSko5b0prOFhzSkpEeE0zVEs5UWJpZmlmekZMbnFl?=
 =?iso-2022-jp?B?NEVKd05uRG80VnphSDAwZ1BGRnNwRGNaczZrcS9GRVVMQ1FaVHltMG5y?=
 =?iso-2022-jp?B?QVdGZGNjYitsdWZ1NjBUKzZ1bG9YZ3l2TlFKTEViTS9hTGFMYkxCN1Vn?=
 =?iso-2022-jp?B?eG0zVG16RVluZmE1dFJIckZKMTRhTFZ4dm1oUGhPTUQyQklHaDR2c1h4?=
 =?iso-2022-jp?B?aGwwcjE0UUtFM3VDbldkUWRneE9hcElueXZubXZYREpUU2hLb2lVak0w?=
 =?iso-2022-jp?B?L3FCWnIrVVo1d0srZUdqOGZJL2I3cmRSZGVzSHhMRmxwWlRkU1g2RzBw?=
 =?iso-2022-jp?B?RjFmRkF3b3ovZ2h3d0JXOUEvTmk2Qk5SWTZJVGsvNVNSRTE4eTEyd29I?=
 =?iso-2022-jp?B?SFoyVmM9?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6147.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6d114573-73b9-4844-1ec5-08da9af0c814
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 10:13:36.5311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 NWdTkLPkdpjeVIL19KC1VfAqHAn5E67y04kxjp539gIot809sJcpbyZe4oxm/CknBTG40aySNA+hKkrSejoPbRMi+V2lObJeTxceThGE3W3qpL7U8+wJzo/kZipQrePF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9592
X-OriginatorOrg: toshiba-tsip.com
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 20 Sep 2022 10:13:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9523

Hi Jan,=20

Could you please check the below revised patch and let me know your feedbac=
k. =20

Thanks & Regards
Shivanand K

-----Original Message-----
From: Shivanand.Kunijadar@toshiba-tsip.com <Shivanand.Kunijadar@toshiba-tsi=
p.com>=20
Sent: Friday, September 16, 2022 5:14 PM
To: cip-dev@lists.cip-project.org; jan.kiszka@siemens.com
Cc: kunijadar shivanand(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <Shivanand.Ku=
nijadar@toshiba-tsip.com>; dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Portin=
g) <dinesh.kumar@toshiba-tsip.com>; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=
=1B(B =1B$B""#S#W#C"~#A#C#T=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>
Subject: [isar-cip-core v2] README.swupdate.md: Add steps to verify SWUpdat=
e on BBB

From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>

Most of the steps are similar for both qemu-amd64 and BBB targets.
Add reference link wherever required instead of repeating steps.

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 doc/README.swupdate.md | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md index 1b242a2.=
.9be3498 100644
--- a/doc/README.swupdate.md
+++ b/doc/README.swupdate.md
@@ -32,6 +32,8 @@ Copy `cip-core-image-cip-core-bullseye-qemu-amd64.swu` fi=
le from `tmp` folder in  host$ scp -P 22222 /tmp/cip-core-image-cip-core-bu=
llseye-qemu-amd64.swu root@localhost:
 ```
=20
+## SWUpdate verification
+
 Check which partition is booted, e.g. with lsblk:
 ```
 root@demo:~# lsblk
@@ -215,3 +217,26 @@ user variables:
=20
=20
 ```
+
+# Building and testing the CIP Core image for BBB
+
+Follow the steps mentioned in the section [Building and testing the CIP Co=
re image](README.swupdate.md#building-and-testing-the-cip-core-image) for c=
reating images and .swu files.
+- Replace qemu-amd64.yml kas file with BBB board specific file i.e=20
+bbb.yml
+- .swu file will be generated in the following folder=20
+build/tmp/deploy/images/bbb/
+
+Flash the BeagleBone Black image into SDcard ``` host$ dd=20
+if=3Dbuild/tmp/deploy/images/bbb/cip-core-image-cip-core-bullseye-bbb.wic =
\
+   of=3D/dev/<medium-device> bs=3D1M status=3Dprogress ```
+
+After flashing the BBB image into SD card, mount the SD card on host PC an=
d copy .swu file directly to root partition like below.
+
+```
+host$ sudo cp tmp/cip-core-image-cip-core-bullseye-bbb.swu=20
+/<mnt>/home/root/ ```
+
+Connect a serial port cable between host PC and BBB.
+Insert SD card to BBB, hold S2 button while applying power supply to BBB.
+
+For verifying swupdate on BBB use the same steps as mentioned in above [SW=
Update Verification](README.swupdate.md#swupdate-verification).
--
2.20.1



