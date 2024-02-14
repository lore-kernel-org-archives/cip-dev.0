Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D15C4829A
	for <webhook@archiver.kernel.org>; Wed, 14 Feb 2024 04:36:19 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.34734.1707885371054544694
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Feb 2024 20:36:11 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 41E4a9EX600663; Wed, 14 Feb 2024 13:36:09 +0900
X-Iguazu-Qid: 2yAaO2s1x9jPSWGFfR
X-Iguazu-QSIG: v=2; s=0; t=1707885368; q=2yAaO2s1x9jPSWGFfR; m=2gcBpR6vOfJnnXxLQ5kWCkW3R2QJacgCbCskvfG6L8k=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1802) id 41E4a7jc1978110
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 14 Feb 2024 13:36:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTimWzGACqQQA5J1+RRwOmlcTuiFtHmlngHV1mmv9s4P19KTkRTi7S8BZtbvGXGh8wBDr1PjNK8uPFhYCIOAQ8kLHriC9PUX5A5PtzV6g32h2fnRV0fkiWJ8/MMBb/W0XbJAjkpxsxlRYxjqOccvKjTUw9NSTQAfh8UFChbGXVbmRUkF5LM6clzc5GPG0aY8bmyCdkTOzQhhSYSV0DrU74BI3zR2E7Byg7s8SxBCK/C8In+zhSanLDYciy6LK5zRkMW4WgTVXaIS4yIx8e5T8K/H2kiJMQkfDG+bpcol6EkMZH6lLV+bU8D3/4/zBAYsK08Xujf0bEngeXlrHGHddA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlzNh9e9MjiTLYE01Ft19MJuffeBukNGIV/d6A/e7M0=;
 b=efbcBoBdOyzH7sVuQdazf5KLdOZCZQnhMwB6BmU2ITHp7f20gnEm3Spq/Dj7BCngOBtywgFWd3G8guotHUnfveVTUuV0G1vPdZuTh8G5MwJJTEbNxRd10TSuOAYrK6XjsKxdGdgSCYdnU9tgJCtaEFkJbEJnb7A6nn/5PULVDqMWwP640la3ZLW+gMhYc44VYgtXvD4DPFFovZHSYnxCU1t8t4/WiY03bC0Bmp7uRk7g1aKr1bGpKjMBsD2l9XNMyXf4UniFEJDiq+fVec5fPwvsmwTv1jAJtmdUdwqwKujEqxEiQ2Xpl8L1mfM8N6dQmb/y6wiC+XnVMxjMSUR6Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <cip-dev@lists.cip-project.org>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <dinesh.kumar@toshiba-tsip.com>
Subject: RE: LAVA test job definitions ( software update, secure boot and IEC
 layer testing )
Thread-Topic: LAVA test job definitions ( software update, secure boot and IEC
 layer testing )
Thread-Index: AdpYW/mgLfuVvDVHQv2V4kqjG1tanACcarPQALyDjoAAT66ioA==
Date: Wed, 14 Feb 2024 04:36:04 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6103E2D6E60760A098F979FEC24E2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103A1EC373CEA6213199114C2472@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYWPR01MB118625EE66B03E0DE98380BDFB7442@TYWPR01MB11862.jpnprd01.prod.outlook.com>
 <OS3PR01MB610381F654F75EE67B00D02BC2482@OS3PR01MB6103.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB610381F654F75EE67B00D02BC2482@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TYYPR01MB8000:EE_
x-ms-office365-filtering-correlation-id: d6a3c91f-5f5a-4a18-f8a1-08dc2d16750b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 oE3vuA5G7Cnz92wBvD1WcbY7cvBOgOKZERxFadNfVT3ahKSkJR+P1wtCzzmg0e+LRzekDlnpYM70tiAq3WgTlZ2ABMLVTrODjg46/8yAGUjB4u0Ioejy5en/9Cy5BTFV1DbTv2lwAFfKF07r6hpkwSVjiD9BMxlhe6i+v2Lbo+Z8Hh34QmiieHL9UOxYjZY3cN+oTyJeSlsr2xFSaS5A2TGRCfb7tUp9xRdo/gyJmhbwC/DoA83DRM+Sl5LGiRtryoU5Lr6Ai/BY/K7Lu7bTtTbVpGl4Gnzjsz43GbbR4zHbAM1T/HgscKwuCPi5jz667NKgqrnNhucjrqJNWpAPTuAf+OkWlcbK0VrOaKnLzx+Gyjb2X21dxkLPPtmiEkt3uwY+od0hMCV5w0UDxJ4MhtdiDGmW7C1zjvg6Dt41SL/yU2ALSzS0SZR4LcVQ/XcR96OC7y0tyJ43RXHliezoUpeVnYjALgLBLGZXlWNKfJhnVRt+fj40w2U0462MxopLzkBQ5uS1DCxLanjCT66keerS+102b/JO4QYw7kIpvHH4VD01Hga802f3rf5NebjpQ3TU8f31B58oraCe8P+AecQ8Un3tKGgb0aYgCGx/4WTqEOmRT2Da6rA3dCcC1vl9GsfWbukej928MgLA2CXEwQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(39860400002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(2906002)(15650500001)(55016003)(41300700001)(478600001)(83380400001)(66476007)(53546011)(38070700009)(66946007)(122000001)(6916009)(66556008)(6506007)(76116006)(71200400001)(8936002)(66446008)(9326002)(4326008)(52536014)(5660300002)(26005)(64756008)(33656002)(7696005)(85182001)(8676002)(66899024)(107886003)(966005)(86362001)(316002)(54906003)(9686003)(38100700002)(166002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?VFNwdHpHc1hyK1B6d3R3Vk9jWVVRei85Q3J0TERBTGo2ZzhSTVRwalRo?=
 =?iso-2022-jp?B?Ymp1TXNPT1V0QUJoR1pGcTEwTTRMdG8yZU9hRGZIa29XZklpWUtxa2d1?=
 =?iso-2022-jp?B?Y0xiVms2Zm9CVEV1U0MxajdVbWZqZ2pxbzJVY1JhdFlpbFFLN3EyVUI0?=
 =?iso-2022-jp?B?anZyUmw2YlRmTFhINjJDekh1ays1UDdsallNMlJDa054K2Z6a2lqMWVj?=
 =?iso-2022-jp?B?RTB2TTFZbk55NHMzZ0lBN3NMZmNrNkduNFBTelVaV0VWMGEwRkJLYUtk?=
 =?iso-2022-jp?B?OWZqdmhMaU53cVJobW16MTllWFZYQjd0YXpFNVRZRlZ1Y2RYMDd6S3BY?=
 =?iso-2022-jp?B?TTVieWhzbzNmU1RSRWcrUHcrZkprb2pCUnkySDdSNXd2WHNNejRqK3Rs?=
 =?iso-2022-jp?B?TXltakdXQi9IMTJoSTMxamUyenkxWjFpbXNyamtBVTh3d2VoanA3Uzli?=
 =?iso-2022-jp?B?eEtPNWNEeERCaFlMYks1ZlY0L1U2M3RhV3hHbzZyZFdGK2p5OU5xQUhV?=
 =?iso-2022-jp?B?U3c0aTNqM1B6TmJtS3FYMGVKSk5GdFZRQnpRUDQzRDlkanNRdUFVUHk2?=
 =?iso-2022-jp?B?RE9QaVRjTXZlM0pCcWlnMUQwUTIzQ05YUS9Fa2owVHgxMnZuNGlScHhw?=
 =?iso-2022-jp?B?NHg4ZU1jOXRzdVBXYTJOVEZuWEZsYmZLTUxITVFQaTdYVlNDVGwrdjdx?=
 =?iso-2022-jp?B?UjdnMmV4MDZpSXJ6aEtvK29oTVlaMVFvSlcwdXlObjgwWDk3LzFURDNX?=
 =?iso-2022-jp?B?SzhCSExlVG5FNFZPcURmMVlncTRyTjdQRkV5dFh6M3l5U29sT05lcFhH?=
 =?iso-2022-jp?B?bG5jYWFmN3Riemx3bXNEZWtDTnRPWThEYmNMQzVDZ1dHUlB6VkFpVzNX?=
 =?iso-2022-jp?B?SVBGWWNpSlJBa0xhZ2lpNDNCUE9ac3Vrd2N6YkFEYWU4dzVHb0R1c1kv?=
 =?iso-2022-jp?B?Sm1zM0Q4RStZeXVKU0ZtSXVIQUJGUXJVdGYvN1pIV1BWWnRhS0ZDd1pE?=
 =?iso-2022-jp?B?b0dPMXJQN2g3ZmJDRW5hRm91b1AzNGVKYjUvblNQZ0RuZTQ2Ry9DWmo5?=
 =?iso-2022-jp?B?cWpZQkVydlRPYXc5YTJmMjlWNWp6V1ZjNXcxdWFNRkJNYUpxYys4OVZD?=
 =?iso-2022-jp?B?VlhicENGQU1jU3JTOGpCTXYzeDUxayt1MXpZLzNlSU1sWXMvSWdyeFNk?=
 =?iso-2022-jp?B?VG5kN0ZLVVRrTExHZkZnQi9SK2E4SGVvT092U2dwTXg2N2RZUjJDc1dr?=
 =?iso-2022-jp?B?RlBWS2pJUVN6YTBxMlZlYTc3V09tdFpZbGVSUlR5REpWNmFQZDB6L2hq?=
 =?iso-2022-jp?B?SVhRZkJYVUUzRXl0QjFtM2lRWkF3TDJCbTQ2dytBUUwrVmFneTNFT0pK?=
 =?iso-2022-jp?B?aDdYdndXaUNVK2tMeElQeTBuOFJoaitsSUdwS29jMk5DdWdCZFJsVHVw?=
 =?iso-2022-jp?B?RjYyNGoyVytZa1JiQlF4cFJ2dGs3T0dxdWk1YTcvaXBnZWdobmlqKzZm?=
 =?iso-2022-jp?B?UUgrVWx2eUlEMkE1T2RLR1ZNSEEwekluSDRuanBzanlXVkVuWCs4WSs0?=
 =?iso-2022-jp?B?YmswSExnc2dkWDRtYitGR2xjTUVmbU9sK1FrS2MvOG5ZZHZrTlVXTExG?=
 =?iso-2022-jp?B?bWNrNmVKTzRmaXUxTDNUc3dwNnR3bE1ueUVJcFJjMHlSTG0vNExzYmsy?=
 =?iso-2022-jp?B?VnZWUWU2L1E4M2l2cEl6b0k2SDB2TlFmbFdjMjdHOXhOZk0vUlZXYXU4?=
 =?iso-2022-jp?B?WWIvVnFaSktkYlpMeFF1UXcwQUVHWEIxeGJoazhRTzdhNW1OVlowb3lo?=
 =?iso-2022-jp?B?TFZtUDJwdzN1YUdTZmY1elZFTm43RlJjajR3UFhLMXdoV3kyK3VoZHlj?=
 =?iso-2022-jp?B?clBISENOOTA4TUprR09GbmtzQm82SzQySmlsdFMyQlNYKzBHT3RLQWg4?=
 =?iso-2022-jp?B?aWtMeXdOZGZMLzZCL0Z3aDdZQit6Rk9GWjFid0Q1WkNmWjZpUzZuWWhl?=
 =?iso-2022-jp?B?aDFlWllMbzU4d2N5NTA4S05aTzhSeFJtSllFdHk4ZW9yb3ExQi85TUdP?=
 =?iso-2022-jp?B?bEhBZS9PbE96ZE5YMG91NVlXWGVUb1BQbkpLdVBRZDhRdUdIQUNKKzAx?=
 =?iso-2022-jp?B?NlZ0djhpdVk3cEhaOWNSa3Rldjk2eGxSaE16ZlcvN2E5bEU1bjkrS2E2?=
 =?iso-2022-jp?B?UmZINkZxLzA0eEFreGNBQ1B3VGpOSzUrM2thM2h1d0ViUGF5d1pScURl?=
 =?iso-2022-jp?B?enZkcGU1VStwWmlLTXo5czByeWI4UTdaOHlUMTNHaC9RUFBVVm1WM3Uv?=
 =?iso-2022-jp?B?U1RoRE9WOW10dkptRzdPQko0Mng2TlJ1MUE9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB6103E2D6E60760A098F979FEC24E2OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a3c91f-5f5a-4a18-f8a1-08dc2d16750b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2024 04:36:05.5486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RsF2KKmE80AZs5GN2USYKLTDbx/14lvdZnxAMIYHO+6dPdo3j/CUBmwkMb+wu8x8FmUp+dBMqQA16x3rb0lhJne8sdj2DNJjbjfcEGRB5nU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8000
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Feb 2024 04:36:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14962

--_000_OS3PR01MB6103E2D6E60760A098F979FEC24E2OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Chris,

We got some opinion from yesterday=1B$B!G=1B(Bs CIP Core meeting that it mi=
ght not be optimal to touch this container Files * master * cip-project / c=
ip-testing / linux-cip-ci * GitLab<https://gitlab.com/cip-project/cip-testi=
ng/linux-cip-ci/-/tree/master?ref_type=3Dheads> and modify that by adding C=
IP Core job definitions and submit_tests script specific for this use-case.=
 Do you think the same ? If yes, then do you think creating a fresh reposit=
ory under cip-testing using which we can build the containers and scripts u=
sed in the CI testing of CIP Core functionalities is a better choice ?

Please provide your opinion on this Chris.

Thanks and Regards,
Sai Ashrith ( T S I P )

From: ashrith sai(=1B$B#T#S#I#P=1B(B)
Sent: Monday, February 12, 2024 8:27 PM
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: cip-dev@lists.cip-project.org; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=
=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayas=
hi@toshiba.co.jp>; dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dine=
sh.kumar@toshiba-tsip.com>
Subject: RE: LAVA test job definitions ( software update, secure boot and I=
EC layer testing )

Hello Chris,

Hope you are doing well.

I will summarize my understanding and approach to trigger CIP Core testing =
LAVA jobs.

So currently we have all the lava templates in linux-cip-ci container which=
 are pre-processed to form final LAVA job definitions using the submit_test=
s.sh * master * cip-project / cip-testing / linux-cip-ci * GitLab<https://g=
itlab.com/cip-project/cip-testing/linux-cip-ci/-/blob/master/submit_tests.s=
h?ref_type=3Dheads> script. As I went through the script I understood that =
a lot of logic is involved in preparing the job definitions from the templa=
te specific for CIP Kernel testing. And this script is run with a trigger f=
rom here https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-/b=
lame/master/linux-cip-pipeline.yml?ref_type=3Dheads#L69. I feel it will mes=
s up the existing testing being done on CIP kernel and shall also require a=
 lot of effort to integrate changes required to prepare job definitions for=
 CIP-Core testing considering huge variations in the final job definitions.=
 And also since submit_tests.sh already with every test action trigger in l=
inux-cip-pipelines.yml, I think making changes to the script to support CIP=
-Core testing will imply that every trigger in linux-cip-ci shall test our =
software update, secure boot and IEC tests on QEMU images which I think is =
not right.

Our requirement here is to trigger a script which submits the CIP-Core rela=
ted LAVA job definitions when a change is made in isar-cip-core. So I think=
 we can a short script similar to submit_tests.sh like submit_cip_core_test=
s.sh and separate folder for LAVA definitions for CIP Core testing in cip-p=
roject / cip-testing / linux-cip-ci * GitLab<https://gitlab.com/cip-project=
/cip-testing/linux-cip-ci/-/tree/master?ref_type=3Dheads> container. We wil=
l run this new script using a test action in .gitlab-ci.yml In isar-cip-cor=
e. In this new script we shall submit only the CIP Core related job definit=
ions which we added in a separate folder in linux-cip-ci container to LAVA =
master.

I chose this approach to minimize the effort and avoid messing up the exist=
ing implementation which is highly specific for CIP Kernel testing and to a=
lso use the existing linux-cip-ci container. This is the first time we are =
testing CIP Core functionalities on LAVA, so initially we started small wit=
h QEMU and in the future once we spread the testing to multiple devices, th=
en may be we can setup a new repository like cip-project / cip-testing / li=
nux-cip-ci * GitLab<https://gitlab.com/cip-project/cip-testing/linux-cip-ci=
/-/tree/master?ref_type=3Dheads> to build a separate container only to deal=
 with CIP Core LAVA definitions.

What do you think of my approach Chris ? Please provide your opinion and co=
rrect me if I am wrong.

I also request other CIP members to provide their suggestions.

Thanks and regards,
Sai Ashrith ( T S I P )

From: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@re=
nesas.com>>
Sent: Friday, February 9, 2024 2:09 AM
To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com<mailto:=
Sai.Sathujoda@toshiba-tsip.com>>
Cc: cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>; ha=
yashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D#I#G""=
#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp<mailto:kazuhiro3.haya=
shi@toshiba.co.jp>>; dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <di=
nesh.kumar@toshiba-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>>
Subject: RE: LAVA test job definitions ( software update, secure boot and I=
EC layer testing )

Hello Sai,

Firstly, let=1B$B!G=1B(Bs get some background for this request.

What is it you=1B$B!G=1B(Bre testing? And when is it you=1B$B!G=1B(Bd like =
the tests to run?
I=1B$B!G=1B(Bm guessing isar-cip-core? And whenever a change is made on _an=
y_ of the branches? E.g. next, master or feature branches?

On the Linux kernel side of things, the test pipelines are driven by linux-=
cip-pipelines<https://gitlab.com/cip-project/cip-testing/linux-cip-pipeline=
s> using the scripts provided in linux-cip-ci<https://gitlab.com/cip-projec=
t/cip-testing/linux-cip-ci>.
However, neither of these repositories are currently set up for cip core te=
sting.
We=1B$B!G=1B(Bd need to add something to isar-cip-core to trigger the test =
jobs, and have a way to create the LAVA test job definitions we need there.

That said, perhaps the templates and submit_tests.sh script from linux-cip-=
ci could be updated to be able to run these security tests?
The build side of isar-cip-core can obviously stay as it is now.
Take a look through the above repos and see if we could integrate your job =
definitions into the same lava template style. Or whether you think it woul=
d be cleaner to take a fresh approach specifically for cip core/security te=
sting.

Kind regards, Chris

From: Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>=
 <Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>>
Sent: Monday, February 5, 2024 5:59 PM
To: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@rene=
sas.com>>
Cc: cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>; ka=
zuhiro3.hayashi@toshiba.co.jp<mailto:kazuhiro3.hayashi@toshiba.co.jp>; dine=
sh.kumar@toshiba-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>
Subject: LAVA test job definitions ( software update, secure boot and IEC l=
ayer testing )

Hi Chris,

Hope you are doing well.

Please review the job definitions attached to this mail and kindly provide =
your review comments.

Doubts:

  1.  Do I need to add these definitions in this repository?. https://gitla=
b.com/cip-project/cip-testing/test-definitions
  2.  I am not sure how to schedule these LAVA jobs in CIP LAVA lab. Can yo=
u please help me with this ?
  3.  I remember you installed swtpm and ovmf packages in lab-renesas-cip s=
lave. Can you install those packages all the CIP LAVA slave machines Chris =
?

Thanks and Regards,
Sai Ashrith ( T S I P )

--_000_OS3PR01MB6103E2D6E60760A098F979FEC24E2OS3PR01MB6103jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:"\@MS PGothic";}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:JA;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:JA;}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:145242541;
	mso-list-type:hybrid;
	mso-list-template-ids:1258724112 67698703 67698713 67698715 67698703 67698=
713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1
	{mso-list-id:1700742943;
	mso-list-template-ids:1252167454;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Hello Chr=
is,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">We got so=
me opinion from yesterday=1B$B!G=1B(Bs CIP Core meeting that it might not b=
e optimal to touch this container
</span><a href=3D"https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-=
/tree/master?ref_type=3Dheads">Files &middot; master &middot; cip-project /=
 cip-testing / linux-cip-ci &middot; GitLab</a> and modify that by adding C=
IP Core job definitions and submit_tests script specific
 for this use-case. Do you think the same ? If yes, then do you think creat=
ing a fresh repository under cip-testing using which we can build the conta=
iners and scripts used in the CI testing of CIP Core functionalities is a b=
etter choice ?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Please pr=
ovide your opinion on this Chris.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Thanks an=
d Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Sai Ashri=
th ( T S I P )<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"mso-ligatures:none">From:</span></=
b><span style=3D"mso-ligatures:none"> ashrith sai(</span><span lang=3D"JA" =
style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none">=
=1B$B#T#S#I#P=1B(B</span><span style=3D"mso-ligatures:none">)
<br>
<b>Sent:</b> Monday, February 12, 2024 8:27 PM<br>
<b>To:</b> Chris Paterson &lt;Chris.Paterson2@renesas.com&gt;<br>
<b>Cc:</b> cip-dev@lists.cip-project.org; hayashi kazuhiro(</span><span lan=
g=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-ligatur=
es:none">=1B$BNS=1B(B</span><span lang=3D"JA" style=3D"mso-ligatures:none">
</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-s=
erif;mso-ligatures:none">=1B$BOB9(=1B(B</span><span lang=3D"JA" style=3D"ms=
o-ligatures:none">
</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-s=
erif;mso-ligatures:none">=1B$B#D#M#E=1B(B</span><span style=3D"mso-ligature=
s:none"> =1B$B!{=1B(B</span><span lang=3D"JA" style=3D"font-family:&quot;MS=
 PGothic&quot;,sans-serif;mso-ligatures:none">=1B$B#D#I#G=1B(B</span><span =
style=3D"mso-ligatures:none">=1B$B""=1B(B</span><span lang=3D"JA" style=3D"=
font-family:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none">=1B$B#M#P=
#S=1B(B</span><span style=3D"mso-ligatures:none">=1B$B!{=1B(B</span><span l=
ang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-ligat=
ures:none">=1B$B#M#P#4=1B(B</span><span style=3D"mso-ligatures:none">)
 &lt;kazuhiro3.hayashi@toshiba.co.jp&gt;; dinesh kumar(</span><span lang=3D=
"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:n=
one">=1B$B#T#S#I#P=1B(B</span><span style=3D"mso-ligatures:none"> TMIEC ODG=
 Porting) &lt;dinesh.kumar@toshiba-tsip.com&gt;<br>
<b>Subject:</b> RE: LAVA test job definitions ( software update, secure boo=
t and IEC layer testing )<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Hello Chr=
is,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Hope you =
are doing well.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">I will su=
mmarize my understanding and approach to trigger CIP Core testing LAVA jobs=
.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">So curren=
tly we have all the lava templates in linux-cip-ci container which are pre-=
processed to form final LAVA job definitions using the
</span><a href=3D"https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-=
/blob/master/submit_tests.sh?ref_type=3Dheads">submit_tests.sh &middot; mas=
ter &middot; cip-project / cip-testing / linux-cip-ci &middot; GitLab</a> s=
cript. As I went through the script I understood that a lot
 of logic is involved in preparing the job definitions from the template sp=
ecific for CIP Kernel testing. And this script is run with a trigger from h=
ere
<a href=3D"https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-=
/blame/master/linux-cip-pipeline.yml?ref_type=3Dheads#L69">
https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-/blame/mast=
er/linux-cip-pipeline.yml?ref_type=3Dheads#L69</a>. I feel it will mess up =
the existing testing being done on CIP kernel and shall also require a lot =
of effort to integrate changes required
 to prepare job definitions for CIP-Core testing considering huge variation=
s in the final job definitions. And also since submit_tests.sh already with=
 every test action trigger in linux-cip-pipelines.yml, I think making chang=
es to the script to support CIP-Core
 testing will imply that every trigger in linux-cip-ci shall test our softw=
are update, secure boot and IEC tests on QEMU images which I think is not r=
ight.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Our requirement here is to trigger a script which su=
bmits the CIP-Core related LAVA job definitions when a change is made in is=
ar-cip-core. So I think we can a short script similar to submit_tests.sh li=
ke submit_cip_core_tests.sh and separate
 folder for LAVA definitions for CIP Core testing in <a href=3D"https://git=
lab.com/cip-project/cip-testing/linux-cip-ci/-/tree/master?ref_type=3Dheads=
">
cip-project / cip-testing / linux-cip-ci &middot; GitLab</a> container. We =
will run this new script using a test action in .gitlab-ci.yml In isar-cip-=
core. In this new script we shall submit only the CIP Core related job defi=
nitions which we added in a separate folder
 in linux-cip-ci container to LAVA master.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I chose this approach to minimize the effort and avo=
id messing up the existing implementation which is highly specific for CIP =
Kernel testing and to also use the existing linux-cip-ci container. This is=
 the first time we are testing CIP
 Core functionalities on LAVA, so initially we started small with QEMU and =
in the future once we spread the testing to multiple devices, then may be w=
e can setup a new repository like
<a href=3D"https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-/tree/m=
aster?ref_type=3Dheads">
cip-project / cip-testing / linux-cip-ci &middot; GitLab</a> to build a sep=
arate container only to deal with CIP Core LAVA definitions.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">What do you think of my approach Chris ? Please prov=
ide your opinion and correct me if I am wrong.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I also request other CIP members to provide their su=
ggestions.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks and regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Sai Ashrith ( T S I P )<span style=3D"mso-fareast-la=
nguage:EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"mso-ligatures:none">From:</span></=
b><span style=3D"mso-ligatures:none"> Chris Paterson &lt;<a href=3D"mailto:=
Chris.Paterson2@renesas.com">Chris.Paterson2@renesas.com</a>&gt;
<br>
<b>Sent:</b> Friday, February 9, 2024 2:09 AM<br>
<b>To:</b> ashrith sai(</span><span lang=3D"JA" style=3D"font-family:&quot;=
MS PGothic&quot;,sans-serif;mso-ligatures:none">=1B$B#T#S#I#P=1B(B</span><s=
pan style=3D"mso-ligatures:none">) &lt;<a href=3D"mailto:Sai.Sathujoda@tosh=
iba-tsip.com">Sai.Sathujoda@toshiba-tsip.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.c=
ip-project.org</a>; hayashi kazuhiro(</span><span lang=3D"JA" style=3D"font=
-family:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none">=1B$BNS=1B(B<=
/span><span lang=3D"JA" style=3D"mso-ligatures:none">
</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-s=
erif;mso-ligatures:none">=1B$BOB9(=1B(B</span><span lang=3D"JA" style=3D"ms=
o-ligatures:none">
</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-s=
erif;mso-ligatures:none">=1B$B#D#M#E=1B(B</span><span style=3D"mso-ligature=
s:none"> =1B$B!{=1B(B</span><span lang=3D"JA" style=3D"font-family:&quot;MS=
 PGothic&quot;,sans-serif;mso-ligatures:none">=1B$B#D#I#G=1B(B</span><span =
style=3D"mso-ligatures:none">=1B$B""=1B(B</span><span lang=3D"JA" style=3D"=
font-family:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none">=1B$B#M#P=
#S=1B(B</span><span style=3D"mso-ligatures:none">=1B$B!{=1B(B</span><span l=
ang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-ligat=
ures:none">=1B$B#M#P#4=1B(B</span><span style=3D"mso-ligatures:none">)
 &lt;<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@t=
oshiba.co.jp</a>&gt;; dinesh kumar(</span><span lang=3D"JA" style=3D"font-f=
amily:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none">=1B$B#T#S#I#P=
=1B(B</span><span style=3D"mso-ligatures:none"> TMIEC ODG Porting) &lt;<a h=
ref=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar@toshiba-tsip.com<=
/a>&gt;<br>
<b>Subject:</b> RE: LAVA test job definitions ( software update, secure boo=
t and IEC layer testing )<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Hello Sai,<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Firstly, let=
=1B$B!G=1B(Bs get some background for this request.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">What is it you=
=1B$B!G=1B(Bre testing? And when is it you=1B$B!G=1B(Bd like the tests to r=
un?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">I=1B$B!G=1B(Bm=
 guessing isar-cip-core? And whenever a change is made on _<i>any</i>_ of t=
he branches? E.g. next, master or feature branches?
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">On the Linux k=
ernel side of things, the test pipelines are driven by
<a href=3D"https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines">=
linux-cip-pipelines</a> using the scripts provided in
<a href=3D"https://gitlab.com/cip-project/cip-testing/linux-cip-ci">linux-c=
ip-ci</a>.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">However, neith=
er of these repositories are currently set up for cip core testing.<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">We=1B$B!G=1B(B=
d need to add something to isar-cip-core to trigger the test jobs, and have=
 a way to create the LAVA test job definitions we need there.<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">That said, per=
haps the templates and submit_tests.sh script from linux-cip-ci could be up=
dated to be able to run these security tests?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">The build side=
 of isar-cip-core can obviously stay as it is now.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Take a look th=
rough the above repos and see if we could integrate your job definitions in=
to the same lava template style. Or whether you
 think it would be cleaner to take a fresh approach specifically for cip co=
re/security testing.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o=
:p></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-ligatures:none;mso-fareast-language:EN=
-GB">Kind regards, Chris<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o=
:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"mso-ligatures:none">From:</span></=
b><span style=3D"mso-ligatures:none">
<a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujoda@toshiba-tsi=
p.com</a> &lt;<a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujo=
da@toshiba-tsip.com</a>&gt;
<br>
<b>Sent:</b> Monday, February 5, 2024 5:59 PM<br>
<b>To:</b> Chris Paterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com=
">Chris.Paterson2@renesas.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.c=
ip-project.org</a>;
<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@toshib=
a.co.jp</a>;
<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar@toshiba-tsip.=
com</a><br>
<b>Subject:</b> LAVA test job definitions ( software update, secure boot an=
d IEC layer testing )<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal">Hi Chris,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hope you are doing well.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Please review the job definitions attached to this m=
ail and kindly provide your review comments.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Doubts: <o:p></o:p></p>
<ol style=3D"margin-top:0in" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1 =
lfo3">Do I need to add these definitions in this repository?.
<a href=3D"https://gitlab.com/cip-project/cip-testing/test-definitions">htt=
ps://gitlab.com/cip-project/cip-testing/test-definitions</a><o:p></o:p></li=
><li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1=
 lfo3">I am not sure how to schedule these LAVA jobs in CIP LAVA lab. Can y=
ou please help me with this ?<o:p></o:p></li><li class=3D"MsoListParagraph"=
 style=3D"margin-left:0in;mso-list:l0 level1 lfo3">I remember you installed=
 swtpm and ovmf packages in lab-renesas-cip slave. Can you install those pa=
ckages all the CIP LAVA slave machines Chris ?<o:p></o:p></li></ol>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks and Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Sai Ashrith ( T S I P )<o:p></o:p></p>
</div>
</div>
</body>
</html>

--_000_OS3PR01MB6103E2D6E60760A098F979FEC24E2OS3PR01MB6103jpnp_--


