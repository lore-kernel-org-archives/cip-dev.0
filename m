Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24DFC4829B
	for <webhook@archiver.kernel.org>; Mon, 12 Feb 2024 14:56:39 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.8245.1707749797897871085
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Feb 2024 06:56:38 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 41CEuZhY515735; Mon, 12 Feb 2024 23:56:36 +0900
X-Iguazu-Qid: 2rWgYo6Fl9F82TvqSW
X-Iguazu-QSIG: v=2; s=0; t=1707749795; q=2rWgYo6Fl9F82TvqSW; m=1gBPSghR3ZzMu3Oo2MpW3Rn2YdoacBabjzL0LlVuLxM=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1121) id 41CEuY443732776
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 12 Feb 2024 23:56:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MiVEqMtJvxgiOAax14PWJb4+UpQFDlSRbuPcfFUbLQK9b9EqxiDrWg9/m7QgnQnh/CofmpZHc0TTY7pA0G+Y9AyC1pc5yjsRQgoCKqqU5r4jUYwO0OmD18McqBY96+cjUs7T8Zpgl4CB31d4m0/ndhdRmtICBBVBUdp6w5biRpkjFtWAftWWot95t6NB2xcjhoRv43t8d9TeJv2N095irIcyes5SyuAbBZrGpeD4K/1W9wZyC4K321c4H0LqbIEtiWPeTyRZXnJ7FjgCuSRwchTZ5AgTl+6KGeS7LoxgWpMbVHY0l8QduitY25un80pBeZLvpW4evHvghhqkSRJg2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRkXXw2N8an9eOpRd3PjPaL5C3AgnixBvZlJjFVDPM8=;
 b=m3PO7x6R7zeFZqpuVTmG3qiUsbIIOo2ADwuP/S9mz5w800gG8sSz8kRx6YZkW4GZLbr/mj9+hibD6sEhXIFtTYqCzHp3sBmq2UjVc1g9lb5WBviFMoCsD3RBrQI4ho8fd8EM5YuLsW02Rv3+WTC4hkD/xRkZHsCkVjhO+vn3wxTKMN8t3pzyfAHIjSNOQhqNRIT8sx1aq1MSsl6BtBZWUDx7CJjhjZn0avtmzTUVQAVl71PlcebHxKiY2WzMlFXE2KDFlns5hu4BDMIs4MBXhWCMAlDpCbT1ja12ePRZ11CiWLtTm+WxyXuknWvwqFhvPi8kjxKmQ2B7pfqpsldppw==
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
Thread-Index: AdpYW/mgLfuVvDVHQv2V4kqjG1tanACcarPQALyDjoA=
Date: Mon, 12 Feb 2024 14:56:32 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB610381F654F75EE67B00D02BC2482@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103A1EC373CEA6213199114C2472@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYWPR01MB118625EE66B03E0DE98380BDFB7442@TYWPR01MB11862.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYWPR01MB118625EE66B03E0DE98380BDFB7442@TYWPR01MB11862.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TY1PR01MB10883:EE_
x-ms-office365-filtering-correlation-id: cc105d05-0cd5-4015-feb3-08dc2bdacd02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 6ypulhcMGXOmee5NjL6lZohzAovtyyf7Q/YOt3KulZSMJWO+8FeWsqzHgabBOpqS1Em2BN9IMsxA6n6x/OQyg/5hg8W6KFHWTA3djLFudAhGU5EoJBmCts+09xkQhaWjuez20ZohFjKnwUzLThEJp2lxXTSx6iL/zDVU8KWW3sQP2m/eKuAUNsRh5Su/dHZN7IP6RW8Oj7Ingiyw/r5k/KL1L1VGTeYrbZZhv6E6ZaBv+VEXkMzJM7o9QaMj98eRzGR+Ftg4PdSccmRNZrvbZKGnJ0Rxc+mbzHjphd6nib8QCoU9i1PXEtrU/OqM5f38u6Vp4UPrOdetyCnK9Uyo7Bh2Ir4qCzdQQavkYqY8lxUDiXM/pEUJMlYq5KTJgrzZ27YGLcTtEijikbQHZ6Fkv23lf6Wf7kQPmx/o5uBNDItyyLoJ58u14Fuv4iBvgR7Q/HhgdM0SVHXRUdzUQ7OnwQ0ZyTk9KjjH6B9YOy/WT2s2wbuwA+3XRD09Hhgv1nze7JcnkrWsF/NFmpfNyrQA3ROFYNyoFGXcsMb6E69zusjuZKMlpeicxvhyZ2O6r1GoXw6nM8u64ziDEggjvWVnzSHuf+m3NCvTpEDw9vxp3Ps5xNuLfgtlwLiM+S4ldpKJC0FDzM1MWVDeGja1OzOGKQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(55016003)(66899024)(38070700009)(9686003)(966005)(15650500001)(2906002)(7696005)(85182001)(6506007)(33656002)(5660300002)(86362001)(76116006)(122000001)(38100700002)(52536014)(478600001)(54906003)(71200400001)(53546011)(166002)(316002)(83380400001)(6916009)(4326008)(64756008)(66446008)(66476007)(66556008)(107886003)(8676002)(8936002)(9326002)(41300700001)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ZmZqREVxZVF6eGJyVDBCN0lSVTQ0N3ZvTEdmcFhJK1RveVQ5K0RpNWl2?=
 =?iso-2022-jp?B?bFZ2ZHVvaGpNT3UzYWN4NzVpMnlsbXdFS2hIdmg4dTAvZllRZ3pibURj?=
 =?iso-2022-jp?B?YXdOU2gyUktodjRoQjNJMEF3V3oxMGdDZU55TXR3TlNpOWhHaTNXUmQr?=
 =?iso-2022-jp?B?eWcwRUxyV2tETDN6VVJYc2xpMmZnUENpK3lodlZtQmU0YVpoYURFaWpQ?=
 =?iso-2022-jp?B?K0tYTndDNmE5aVZkZU5nTzlDVnhWNER5UHVQZHNES1U5N0xXVDdjbmVk?=
 =?iso-2022-jp?B?TXUvSHZyY3RKVCt1b0dHcVlLNnNXOFg3NCtZaElEeWxGRVFWUkdRQStp?=
 =?iso-2022-jp?B?Wmk2Tm5rdm1iMkVyMGRySWlnR1NnNkR3a2tyS2x2eWVUVnNkc2J2VGt0?=
 =?iso-2022-jp?B?dnc3cWtPOWhFckhxcHRiaFNNUGM5VG9nb2t5TDY1ZldnTkM5aHYxV0o4?=
 =?iso-2022-jp?B?ek9iREtqdExBczZIVkJSQ1N1SGc4b2lsWENwbjBQT3NubmdtNTNsYkFG?=
 =?iso-2022-jp?B?MC9OUnd2V0R0eG4rUXk0aUpZbWZnQXpZK2ZXR1VJdkVzYll5aXd0ZWl1?=
 =?iso-2022-jp?B?Nllwb2JMMlJLbFdnWDBTTXZ5ZjZYS3VlamdJSkNPZ0szdFpCVE96N1pL?=
 =?iso-2022-jp?B?MmUvbGZDcVI4YWVOZDhwMVoyY1o0NG9JQUlZN0RQZlNCTnBleFhiR1dL?=
 =?iso-2022-jp?B?V3MyNUhMKzhrVTJzUERBVmF6MmZ6bHdSUE1uaVlKQVk2TS8vTGEvdFVz?=
 =?iso-2022-jp?B?eGU4UFdYWjFvR2F5cDVnN2NFL2hMKzlUT3NuVzU1c0NzZFUzTzcyU2xF?=
 =?iso-2022-jp?B?d1dxL015TVljZzIrbFg3TXFyUytJV01kNm9XQUFYU2RGNzlBbWk0V1ZY?=
 =?iso-2022-jp?B?VlFoNDZPd3lUdWhPQUhMWjJTWFFtdENmL3c2dG01TTg4R2tKR01xZGFQ?=
 =?iso-2022-jp?B?aHMyZXN1eTNjdmNvRlJFeE5kYlp5NXJoajVqQ1J6VU5wT0E0c3RONmpF?=
 =?iso-2022-jp?B?SjhucU1aVFZ2Y0tWckRrWmRySEhCY0ZMbDVKdFBFWkY5Q05ZQm5LY3RZ?=
 =?iso-2022-jp?B?a2NCOFJ4cy9hT0dMdDRKOElBclVNa0lwOVhkRTZKWlpFR2hrVndwVmVU?=
 =?iso-2022-jp?B?ay9YbUFOOTJIT2hzeWZVTGl4VTlkK1VSTzVhYjBwSSs5c3BXbFRYaDZp?=
 =?iso-2022-jp?B?R3RjdTM2QWs5UytROWs2aTd1TmM5WU5uS0Frd29aTzZDSndiajJ1M1dX?=
 =?iso-2022-jp?B?QUM4dGtvZXQxcDMzYmVWeUE1VVpjVlFqdkQ4LzkwdU81NmxtY3QzNFJL?=
 =?iso-2022-jp?B?dG5VMTY1RDROQks1MWN5MnJSM2pmd1d3RFVmQjN1SE1GdWxobHJvd3U2?=
 =?iso-2022-jp?B?S1YySlRTMGpqZWZLR012Y0tycUQ3NGJKR0pFUUlMZEdHbWdNL3pma09H?=
 =?iso-2022-jp?B?Ym05V2hPalFtZnZsamxucDdWNHdQS2ZGdmRCODQ5WlFDMldnbXhqVzB3?=
 =?iso-2022-jp?B?ZlNaOHNIdWZYcmU2SWRkWWZrUlR0STZ0WTJzSFNzL2RDUEVkU2NBOVpa?=
 =?iso-2022-jp?B?cW9IckJ5YTZIVnMrRkw0a2Q1QktPU3Z6ZENKNHVIZnZJVE5zMmkxRFl4?=
 =?iso-2022-jp?B?Vk1qTDkwNTZ4Z0c4SWdCUVAxYVhYcjdMT3BLWlYrQ2FHbmYyb1VQN21n?=
 =?iso-2022-jp?B?K25BejhLenBPa0J1bHgyN3NSMno1SUJ6MlQ1Q0Q4VUxzbGFaREJXQ2ZC?=
 =?iso-2022-jp?B?a2t0VUdBL2IyWGZTVkNHQ0s5bnU3UUQ4d2VPcEliQTkxaFJOZzlwU0Js?=
 =?iso-2022-jp?B?RHN6dHVnV3cxWlZDdzRtckRpbDlKVWhHTGk3Y2VSQm1GSVk2cFU1MVBY?=
 =?iso-2022-jp?B?ZU1HNGFsNlExd2VTYjV5OHV6TWw0b3U3UGtRamFDRnZRTlZpNlEvazJM?=
 =?iso-2022-jp?B?L0RUNlhqb01za1VpMmcyT1ZWY2VETjAxNFB1K29IL1NkaGJQWEtTRzZT?=
 =?iso-2022-jp?B?QWFjbGRtc3c0TW9kVGErSmFtWlFrWDhrZjZrdUEzbTFWTjh3djcrckhk?=
 =?iso-2022-jp?B?S2tKTVM2enhSdnJkUDVlM1llbzhjS3NqSURaWk9IVVF0emlhd3AyZTVI?=
 =?iso-2022-jp?B?NWFDVk5YS3I3S2NDalEvUUE3V0lVMHdpVmdZQTBUaVd1Vng4dUtZZDRV?=
 =?iso-2022-jp?B?YWpGV01FQnZzaldFMVEwb0RudlFnWFFYZFlzeTVEVmNpY0xGQ3FwMHVF?=
 =?iso-2022-jp?B?VThmaDZDb2h0Q3NXaUpCUHhiVUJFOGFVV0VXMlEwMUFXeC9YRG0yczdZ?=
 =?iso-2022-jp?B?MTBFUGZxTGZJVFRDRzBqOWNxUUR5TWV4ZFRBTkZSWnN5UXJPZ1VWUjVR?=
 =?iso-2022-jp?B?T1ViZnZJTmJvem5YNkt4YlZkcFQwZ3ZvQVhaWDV3SEVsNVBBRkptOTVY?=
 =?iso-2022-jp?B?R0QreVB3PT0=?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB610381F654F75EE67B00D02BC2482OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc105d05-0cd5-4015-feb3-08dc2bdacd02
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2024 14:56:32.1568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JnRFi5VxgWntVAaX/Gse0Aik9/JQjOBrRMogmDdlX7aURmttnks0+TDYvsKksW7dCuedwum0kIpg+2nDinhiKBqWbuxpGOlsRoruTJpzfFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10883
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 Feb 2024 14:56:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14922

--_000_OS3PR01MB610381F654F75EE67B00D02BC2482OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

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

From: Chris Paterson <Chris.Paterson2@renesas.com>
Sent: Friday, February 9, 2024 2:09 AM
To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>
Cc: cip-dev@lists.cip-project.org; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=
=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayas=
hi@toshiba.co.jp>; dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dine=
sh.kumar@toshiba-tsip.com>
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

--_000_OS3PR01MB610381F654F75EE67B00D02BC2482OS3PR01MB6103jpnp_
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
	{mso-list-id:751319787;
	mso-list-template-ids:590908048;}
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
b><span style=3D"mso-ligatures:none"> Chris Paterson &lt;Chris.Paterson2@re=
nesas.com&gt;
<br>
<b>Sent:</b> Friday, February 9, 2024 2:09 AM<br>
<b>To:</b> ashrith sai(</span><span lang=3D"JA" style=3D"font-family:&quot;=
MS PGothic&quot;,sans-serif;mso-ligatures:none">=1B$B#T#S#I#P=1B(B</span><s=
pan style=3D"mso-ligatures:none">) &lt;Sai.Sathujoda@toshiba-tsip.com&gt;<b=
r>
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

--_000_OS3PR01MB610381F654F75EE67B00D02BC2482OS3PR01MB6103jpnp_--


