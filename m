Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A440C48BF6
	for <webhook@archiver.kernel.org>; Wed, 21 Feb 2024 12:31:57 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.11737.1708518710832643380
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Feb 2024 04:31:51 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 41LCVmZk1073559; Wed, 21 Feb 2024 21:31:48 +0900
X-Iguazu-Qid: 2rWgWcEMvC3EF2m0DQ
X-Iguazu-QSIG: v=2; s=0; t=1708518708; q=2rWgWcEMvC3EF2m0DQ; m=vWSNZ+Eop2gb1o7eSA9swKuI58T0JWvsTysb9PTpHNs=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 41LCVlEF2745795
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 21 Feb 2024 21:31:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/rs0skM+f1GeZdL+c78vuCiSfMS/8lvfhIRsjjPq3asE9WpGofQhAF9W5AG2fOrrFzdSjwwczkl/1+GOtNUHfJi5RCkw+fcNhDKU/kBscY1OHtx3Vccr9EKjlLoUREMuunYL3OHtv9qtipJJngIF5UFI/oT22hGvLMHw9U+rf5I8Z9TuX52hLH9l1XD5w9kXgKMV+OjHyKInBVKmjoeEd7WRwZx9iyaZGvkDzoDmGCOjtt/KyOgeR/FhXVp1sfKQtdRdTm6/E4uVJJZWCIiO5qNlOzlMr9dg291B/kaGNNTA9qgwHLq2V6wOffDWH+kIbq0LTZi6utoKOfxUgVuTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKHVimx+Cibo98NvGfyGMfUn/TJoN3KanqbuJ4XIwOI=;
 b=g2nK5zjzAXj2/AG7nRU/LEL2IoPjr6sDgsifmY9tbxcZM8G6GFR8JiC4Bm+ebnChjQHElGyOgy+hA7fkGerdR6N/NOPT/yqnaIunBMBJrQQY9L6GQSzLWbBa+CDpm0wselEROtP2al0xN9F9hc5hy8wIt2gOtU4KznG7cn1CvRwxeFJ0HlOD1dWICJrHeqT1hqTbaILhJevWP1WgKeTX6ZybU3nvXaxUSRO/jQTd1PLofNw3rTWUQ52dag54GsJItHo0/D2HGLNk34AgFcp39P9pZU+HeylWJsBl4JI3Iw3nCyUApuMwpu7xGvF6P6YffHM4vU8w5edqbWF5wdCYbg==
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
Thread-Index: 
 AdpYW/mgLfuVvDVHQv2V4kqjG1tanACcarPQALyDjoAAT66ioAD7Ws/gAHPcRqAAAY+0YA==
Date: Wed, 21 Feb 2024 12:31:45 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB610352AB4942C739EFFB9C6AC2572@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103A1EC373CEA6213199114C2472@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYWPR01MB118625EE66B03E0DE98380BDFB7442@TYWPR01MB11862.jpnprd01.prod.outlook.com>
 <OS3PR01MB610381F654F75EE67B00D02BC2482@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <OS3PR01MB6103E2D6E60760A098F979FEC24E2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <OS3PR01MB61034E05C271281A1CD2FE78C2512@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYWPR01MB11862816FF930969C5B302BF4B7572@TYWPR01MB11862.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYWPR01MB11862816FF930969C5B302BF4B7572@TYWPR01MB11862.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TYCPR01MB10649:EE_
x-ms-office365-filtering-correlation-id: 1da4848d-b8da-4afa-d21b-08dc32d910df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 icLiJ2i5OO+nJbkV3OJjRQ9DBnNNSJQCyY39Iyp0epc6SuFGE1FQvzu9qYBcCiWmXXHHbcszJijkWpL4MvmB28oXpgwJuDcza3dVyUBFvYYrCvmKAAIz6VUj/mfgbVmXR6gxLF+9rwe6jylait22PQKUK1zomXCHgqF8XPf+OnhK9bA4dJ3P6PNetMmjIUlzWVngMrSgwqPb7T2fmRCapb6ikoEHfdgLGBxPATfQck3SttL2/Aegd8PCAE0yMid3CD+3/c5IA6OfaNh/mCN2KcjVT67n02UpauzPrZlnW/3eaQvLJeDC5Qo0MtZOBmuGfSRztZEMIoBjBqkkkUjnY6+yiywfCm5INBnE0u1L8ySKtnYfASMZGP20+WDAdXYM2/R6eIo0wTfKHhr5DdqMY0hCQokbwb/3sdBzwVRhQf1yy+mrL+WVV2A66ddxhP7/4kLULRHaz+nRelF6SSIyVA/iRpuCodwKjGF8HNn1ceaMTvmXNBmVWpFnxTtJema/pCtgIcQtJYC5lIhjLPglCG88hGiwH4lBok9svMLQtdoq+Kpj42pS+w4OnQSNU9U5JcgDaT+2nRu03ua+gCWxJFiH7bXqqQ1damXTgOXE+es=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Y3F3dS94YnJBTnE1cHNESkFia3NYdE8xRXlOWFdFVmhzYXZMb2ZQL0Vm?=
 =?iso-2022-jp?B?MzVZMy9nU1BUWVVORXU2SXdTdjhYUWgyeTdZekFVbEZHZUIxaUppTnBn?=
 =?iso-2022-jp?B?RUtXS2FzcjRxS1llTEVZMjlZQzd6RFZSSXJya3ZZTzFyS0RIT2hEL0ox?=
 =?iso-2022-jp?B?S0xSb1d4RGtrSzhZejNtbTFPcnZ0cGtUazhwcXN0OFRoYi95VVVvYm90?=
 =?iso-2022-jp?B?WHN4MmU4QTFFQlBuRyt0cjJVODNmSnRxWVdvR3l2T201ZGhKWlFQcEph?=
 =?iso-2022-jp?B?MFJGcW95UExSaXArRFd4TTRYR2lHQTVXTHdmS1Y3RHowL3d1RTZqK2x0?=
 =?iso-2022-jp?B?Z3ZNZ3V5YkNhYWRQWklsSWJQc245ZGIwQVRncjFPVGxQKzN0RlJXYjln?=
 =?iso-2022-jp?B?c3k0US9wVDVZaTZkMS96Sk5TWWhVQVJrMTB6ckszQlRzOThOY1p5WFBr?=
 =?iso-2022-jp?B?VXZJeUZRRlNyZ1FWM3V3VUsyU1lKbFBNTDVmU3I2amxWdGlxcmg3M3JE?=
 =?iso-2022-jp?B?UzAzbk55RUdaeHNCbThvQkVWb1NWYnVYb1pxVlZnVHRQY3RYNW1BWmlW?=
 =?iso-2022-jp?B?cG92OE8zSzZ2VytGeDVuaEJpSDVhMjN5TEMxbmZXU29NTGdZYm8wYTFU?=
 =?iso-2022-jp?B?WUFYMDY5b1JLeDhHUFk5L2VUd1R0bWhocW44WUhpM2NudjU0dHNGbGk0?=
 =?iso-2022-jp?B?V1JHYklnZWw1QVJuZlg0NzM1WDh2c2lpM0FqdDhkaFFCNlBnZFFPNjlD?=
 =?iso-2022-jp?B?QVNxQmVEWlc1QzZ1MVIzcTlzcjJ1WDVjYklFZ2l5bEkwVVIzNWd3OUFl?=
 =?iso-2022-jp?B?R2FhUTYxUGtSYU1WbHJoN2lKRkF0bmV4R3IrQ0gxMGJsZ0dxQXFpanNa?=
 =?iso-2022-jp?B?SXhIODFlSmliRDVtb0NPQnRzc041RzJOb2VCM3psQU1QV09FY282MHZN?=
 =?iso-2022-jp?B?TkVkZlVKSHhlQVMyQmRlQjRwT0ZtVWVGcUpLa2N3YjBIdzI5MExZdG5y?=
 =?iso-2022-jp?B?OEdjekZnOVYwNlNXb3ZBWjhCZGdta05JRjl6STFtL0docUdEamFIRTA5?=
 =?iso-2022-jp?B?cFZtNk03NlFhTStPNFFrM0wrSzFGMTl3Rno2SmFRSGQzYWloWmpjMUZs?=
 =?iso-2022-jp?B?bE54cC9qejR4NjlWWkxpU28wU05Va1c3cy80UzB2WW1sR01OTkFSck16?=
 =?iso-2022-jp?B?bXVUM2dpeVpjekgwTUs0d2ZqWGpvSzdxV1AxOVdWQ25NN2pJcFRkSHhZ?=
 =?iso-2022-jp?B?WEtrVDJNVjdNQm5nM21sSG9oNlFmcVRuYUlnQlowbERKUjYyeUJKQmN2?=
 =?iso-2022-jp?B?MFd5UzV2QzFDdnlKZkVXRm5KalhRdldNdHh6cW1rNE5NZzJiVVcxcE1p?=
 =?iso-2022-jp?B?TzJVTnI0TUtJM1laU0wvZlFzN1FLVXNiWW9SODRQZWhRSlB2QkRrQ25I?=
 =?iso-2022-jp?B?QzVGSlo3cmJqQ1MzSnk1WGJtQmR4NitSdnZCNmIvVERjNHdyN0hmZHJx?=
 =?iso-2022-jp?B?d2Z5QjhJMjU5Y1liajBCWGZCTW9GUG8rTzZYQVhQRy9CV3Y5SHkyUCtW?=
 =?iso-2022-jp?B?VnpnVDFuMVc3VFFYWloxWWVoZmt3RmVSSnZJdVFJOU9YSWMxelUyM2ho?=
 =?iso-2022-jp?B?TE5rVmpmQ3RsUk5BU3p1TkxWYWk5YUZEYkhmYmxaK0l4M1hSYWhJTHRU?=
 =?iso-2022-jp?B?NmxwQWNNRlI1ZEZLWk0zN3Z0Tkdkak93dWtZUWxEcStaUGtZbDJZZTFE?=
 =?iso-2022-jp?B?ZGMxN2VQSndvNVUxOHpaeEZpSFlydG1ORkFaZG5xVGZ6ZDI2L3dUNjgv?=
 =?iso-2022-jp?B?ZjkrUjY2L3ZjY20xQUlrSmdhc25FR0duL25CTzM0UDRjUmY2S1BPRXJh?=
 =?iso-2022-jp?B?Yy9FZFNhZDZtYlM3ZENCOTVaTUZ1M281SUhGWEVudk4xTXV5WTdRR1Vv?=
 =?iso-2022-jp?B?TVgvc3djVmxnRmZ2V3NWQ0NCWEZaNzNGNm1YV2Y2bVRDbFE2Rlhwckpo?=
 =?iso-2022-jp?B?VzFIRXRWNUtpaGM5Wml0RkFWcFlxdFZDNFFvcnIzdGZwTGU2bXBOM2lG?=
 =?iso-2022-jp?B?ODE1ZDJOenBVMUV6VDBHeWFobTgzejNwNzdkbjljQ2d0SWhJRFY0TmVG?=
 =?iso-2022-jp?B?Uzdnb0RMRHgxVWc4Qzl1S2dsdjVKaGVSMEIxellLbGc2NDFNMWZKby9M?=
 =?iso-2022-jp?B?ejc3dGlFWThFdm0wNHByRVE5VUk4ckQyWWs2VVpWa0p6VzJ0VWlvS2Fr?=
 =?iso-2022-jp?B?V0lwK2JNRUEwODVudTZ2MnZHMDRzdlB1SGlOZWhmeEFLb2xtRVppbytO?=
 =?iso-2022-jp?B?SnNXaG9nQ2o4eXlTL050aFh0cC9PN0IzS3c9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB610352AB4942C739EFFB9C6AC2572OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da4848d-b8da-4afa-d21b-08dc32d910df
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 12:31:45.1565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kzbFhx0xCd4SLdWxFFbwHvY+LYzjpeRUY/8YLqL/5i2rYSwD16T241MYen4eUlvwDKdmC51DOn+bTv6hh7eH+ZFFlTjhI648VLUQwMT4aFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10649
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 Feb 2024 12:31:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15056

--_000_OS3PR01MB610352AB4942C739EFFB9C6AC2572OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

Then I shall proceed with creating a project under cip-playground for this =
use-case. I shall request for your review once it is done.

Take care Chris.

Thanks and Regards,
Sai Ashrith ( T S I P )

From: Chris Paterson <Chris.Paterson2@renesas.com>
Sent: Wednesday, February 21, 2024 5:46 PM
To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>
Cc: cip-dev@lists.cip-project.org; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=
=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayas=
hi@toshiba.co.jp>; dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dine=
sh.kumar@toshiba-tsip.com>
Subject: RE: LAVA test job definitions ( software update, secure boot and I=
EC layer testing )

Hi Sai,

Sorry for the slow reply, I=1B$B!G=1B(Bve been poorly.

It=1B$B!G=1B(Bs certainly an option to separate the cip-core testing contai=
ner/scripts etc. from the kernel testing, however most of the functionality=
 will end up being very similar, so we=1B$B!G=1B(Bll end up with duplicatio=
n.

Feel free to create your project(s) in cip-playground, then we can move the=
m across to cip-testing when ready & we have approval from the TSC.

Thanks, Chris

From: Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>=
 <Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>>
Sent: Monday, February 19, 2024 4:32 AM
To: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@rene=
sas.com>>
Cc: cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>; ka=
zuhiro3.hayashi@toshiba.co.jp<mailto:kazuhiro3.hayashi@toshiba.co.jp>; dine=
sh.kumar@toshiba-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>
Subject: RE: LAVA test job definitions ( software update, secure boot and I=
EC layer testing )

Hello Chris,

Hope you are doing well.

I request you to please provide your opinion about creating a fresh reposit=
ory under cip-testing which serves the purpose of creating container having=
 CIP Core testing lava job definitions, lavacli dependencies and a simple s=
cript tp submit the tests to CIP LAVA server. We shall invoke this script i=
n a separate action in .gitlab-ci.yml file in isar-cip-core.

Thanks and Regards,
Sai Ashrith ( T S I P )


From: ashrith sai(=1B$B#T#S#I#P=1B(B)
Sent: Wednesday, February 14, 2024 10:06 AM
To: 'Chris Paterson' <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@re=
nesas.com>>
Cc: 'cip-dev@lists.cip-project.org' <cip-dev@lists.cip-project.org<mailto:c=
ip-dev@lists.cip-project.org>>; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(=
B =1B$B#D#M#E=1B(B =1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@t=
oshiba.co.jp<mailto:kazuhiro3.hayashi@toshiba.co.jp>>; dinesh kumar(=1B$B#T=
#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshiba-tsip.com<mailto:dinesh=
.kumar@toshiba-tsip.com>>
Subject: RE: LAVA test job definitions ( software update, secure boot and I=
EC layer testing )

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
To: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@rene=
sas.com>>
Cc: cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>; ha=
yashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D#I#G""=
#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp<mailto:kazuhiro3.haya=
shi@toshiba.co.jp>>; dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <di=
nesh.kumar@toshiba-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>>
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

--_000_OS3PR01MB610352AB4942C739EFFB9C6AC2572OS3PR01MB6103jpnp_
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
	{font-family:Gulim;
	panose-1:2 11 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"\@Gulim";
	panose-1:2 11 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:"\@MS PGothic";}
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
	{mso-list-id:923681598;
	mso-list-template-ids:-1308691426;}
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
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Hi Chris,=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Then I sh=
all proceed with creating a project under cip-playground for this use-case.=
 I shall request for your review once it is done.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Take care=
 Chris.<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><b><span style=3D"mso-ligatures:none;mso-fareast-lan=
guage:KO">From:</span></b><span style=3D"mso-ligatures:none;mso-fareast-lan=
guage:KO"> Chris Paterson &lt;Chris.Paterson2@renesas.com&gt;
<br>
<b>Sent:</b> Wednesday, February 21, 2024 5:46 PM<br>
<b>To:</b> ashrith sai(</span><span lang=3D"KO" style=3D"font-family:&quot;=
Gulim&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:KO">=1B$B#T#=
S#I#P=1B(B</span><span style=3D"mso-ligatures:none;mso-fareast-language:KO"=
>) &lt;Sai.Sathujoda@toshiba-tsip.com&gt;<br>
<b>Cc:</b> cip-dev@lists.cip-project.org; hayashi kazuhiro(</span><span lan=
g=3D"KO" style=3D"font-family:&quot;Gulim&quot;,sans-serif;mso-ligatures:no=
ne;mso-fareast-language:KO">=1B$BNS=1B(B</span><span lang=3D"KO" style=3D"m=
so-ligatures:none;mso-fareast-language:KO">
</span><span lang=3D"KO" style=3D"font-family:&quot;Gulim&quot;,sans-serif;=
mso-ligatures:none;mso-fareast-language:KO">=1B$BOB9(=1B(B</span><span lang=
=3D"KO" style=3D"mso-ligatures:none;mso-fareast-language:KO">
</span><span lang=3D"KO" style=3D"font-family:&quot;Gulim&quot;,sans-serif;=
mso-ligatures:none;mso-fareast-language:KO">=1B$B#D#M#E=1B(B</span><span st=
yle=3D"mso-ligatures:none;mso-fareast-language:KO"> =1B$B!{=1B(B</span><spa=
n lang=3D"KO" style=3D"font-family:&quot;Gulim&quot;,sans-serif;mso-ligatur=
es:none;mso-fareast-language:KO">=1B$B#D#I#G=1B(B</span><span style=3D"mso-=
ligatures:none;mso-fareast-language:KO">=1B$B""=1B(B</span><span lang=3D"KO=
" style=3D"font-family:&quot;Gulim&quot;,sans-serif;mso-ligatures:none;mso-=
fareast-language:KO">=1B$B#M#P#S=1B(B</span><span style=3D"mso-ligatures:no=
ne;mso-fareast-language:KO">=1B$B!{=1B(B</span><span lang=3D"KO" style=3D"f=
ont-family:&quot;Gulim&quot;,sans-serif;mso-ligatures:none;mso-fareast-lang=
uage:KO">=1B$B#M#P#4=1B(B</span><span style=3D"mso-ligatures:none;mso-farea=
st-language:KO">)
 &lt;kazuhiro3.hayashi@toshiba.co.jp&gt;; dinesh kumar(</span><span lang=3D=
"KO" style=3D"font-family:&quot;Gulim&quot;,sans-serif;mso-ligatures:none;m=
so-fareast-language:KO">=1B$B#T#S#I#P=1B(B</span><span style=3D"mso-ligatur=
es:none;mso-fareast-language:KO"> TMIEC ODG Porting) &lt;dinesh.kumar@toshi=
ba-tsip.com&gt;<br>
<b>Subject:</b> RE: LAVA test job definitions ( software update, secure boo=
t and IEC layer testing )<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Hi Sai,<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Sorry for the =
slow reply, I=1B$B!G=1B(Bve been poorly.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">It=1B$B!G=1B(B=
s certainly an option to separate the cip-core testing container/scripts et=
c. from the kernel testing, however most of the functionality
 will end up being very similar, so we=1B$B!G=1B(Bll end up with duplicatio=
n.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Feel free to c=
reate your project(s) in cip-playground, then we can move them across to ci=
p-testing when ready &amp; we have approval from the
 TSC.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o=
:p></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-ligatures:none;mso-fareast-language:EN=
-GB">Thanks, Chris<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o=
:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"mso-ligatures:none;mso-fareast-lan=
guage:KO">From:</span></b><span style=3D"mso-ligatures:none;mso-fareast-lan=
guage:KO">
<a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujoda@toshiba-tsi=
p.com</a> &lt;<a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujo=
da@toshiba-tsip.com</a>&gt;
<br>
<b>Sent:</b> Monday, February 19, 2024 4:32 AM<br>
<b>To:</b> Chris Paterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com=
">Chris.Paterson2@renesas.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.c=
ip-project.org</a>;
<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@toshib=
a.co.jp</a>;
<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar@toshiba-tsip.=
com</a><br>
<b>Subject:</b> RE: LAVA test job definitions ( software update, secure boo=
t and IEC layer testing )<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Hello Chr=
is,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Hope you =
are doing well.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">I request=
 you to please provide your opinion about creating a fresh repository under=
 cip-testing which serves the purpose of creating container having CIP Core=
 testing lava job definitions, lavacli
 dependencies and a simple script tp submit the tests to CIP LAVA server. W=
e shall invoke this script in a separate action in .gitlab-ci.yml file in i=
sar-cip-core.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Thanks an=
d Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Sai Ashri=
th ( T S I P )<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
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
<b>Sent:</b> Wednesday, February 14, 2024 10:06 AM<br>
<b>To:</b> 'Chris Paterson' &lt;<a href=3D"mailto:Chris.Paterson2@renesas.c=
om">Chris.Paterson2@renesas.com</a>&gt;<br>
<b>Cc:</b> 'cip-dev@lists.cip-project.org' &lt;<a href=3D"mailto:cip-dev@li=
sts.cip-project.org">cip-dev@lists.cip-project.org</a>&gt;; hayashi kazuhir=
o(</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans=
-serif;mso-ligatures:none">=1B$BNS=1B(B</span><span lang=3D"JA" style=3D"ms=
o-ligatures:none">
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
<b>To:</b> Chris Paterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com=
">Chris.Paterson2@renesas.com</a>&gt;<br>
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
</div>
</body>
</html>

--_000_OS3PR01MB610352AB4942C739EFFB9C6AC2572OS3PR01MB6103jpnp_--


