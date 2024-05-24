Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4758DC25B74
	for <webhook@archiver.kernel.org>; Fri, 24 May 2024 07:44:49 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.10787.1716536677829769302
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 May 2024 00:44:39 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 44O7iZ7D570255; Fri, 24 May 2024 16:44:36 +0900
X-Iguazu-Qid: 2yAbNsrDKHLxbDuHbP
X-Iguazu-QSIG: v=2; s=0; t=1716536675; q=2yAbNsrDKHLxbDuHbP; m=2Ai57RwSehztA3IVQbVPBtDun1oYj99OHFxQ6qcA5A8=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 44O7iYwl400802
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 24 May 2024 16:44:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l28AvqKpe6U+kshGfhUtnXdenSTQTeuYvmJHrowSf1yFX2MpKVwRuNSJX6qNbQ0LQXIxk3uO1Fp+udT6nZ8Y8932olwDvZud+lUwDVX1q9J1Ko31I4ZbkEFoXieD92P3Nj1w9ZWA5PKJG/fwgGNJMfzjn5Eew/f6W4FnHiO+Mv0UiV8u9hdGXxYV3KIx+JawVbUKvub9ge0WF+737jZ2cB7MutHFV8hAlRnT0oJLFk+FsOjrX4JZnbKyDtU7tM27sePpTw5AzgObPEnDXCPIzpypCC4DDUfX2k1Ad8BXntTLh6Q8yJe1ljwjS+7/8kbvRbLeZCCFJKG8fzHSfXU8Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BJJUjt1tJ86n7eUPsWKGdULMY0WUvHiJisIhMxL72M=;
 b=fxLO22Jnh1F0tXr6iD3w6pKfAhlRtpBAsZNVjqn53/Z+mz+HR9iYuJgvPGCQmUxJWbYArWs3ZuVweReY4wc9N/XjW0py+xsReqT2ruqlzBSv35SkzKRJwcIFYOYjGCoXjy1HC7VAowkfKnNRU6y80vpK2F6HrKElNsV/2FPhalPTJyyWO+IaE3PDDKjnzO+073TabjgP2u2jcoDSR9bYaAx5FDtwITPuh8XLhFb2oS2K9SgtAQYTiHILKoyVpWoFDsAaIjo60xATRp88X04jiiT2rhAyC/EPvz+GhrAhDlWbU4/4xfIOl+D7YY6MX08lI0+gz3JnE8wIteoFh9h9tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: Request for updating device dictionaries
Thread-Topic: Request for updating device dictionaries
Thread-Index: AdqmtLnvothy4nUKQBSdfu8qbwxdbQD6sUBwADL8pYAAAIHQ4ABsGuiAACP4ZqA=
Date: Fri, 24 May 2024 07:44:30 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6103B95D6D38ECAB1BE70F18C2F52@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103AFC364EE1AD1A9C0C81AC2EC2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <OS3PR01MB6103F00964E26A0F5D38A8ECC2E92@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYWPR01MB11862221FADD6EE25E032DADBB7EA2@TYWPR01MB11862.jpnprd01.prod.outlook.com>
 <OS3PR01MB610353B51E2D66C802A5104DC2EA2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYWPR01MB1186210AA7A8F762825C4BD44B7F42@TYWPR01MB11862.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYWPR01MB1186210AA7A8F762825C4BD44B7F42@TYWPR01MB11862.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TY3PR01MB11057:EE_
x-ms-office365-filtering-correlation-id: 87fd3730-d491-4c93-30ed-08dc7bc5589e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?bmRSczNEZzR6NEp4eCtmZ3Y0cVlVM2tEZTRrN3pyb3B3a1VvQjljUTJo?=
 =?iso-2022-jp?B?UzlhcVJXWXB3ZFR4U1R2QlZISFcwYzhycDRmbjdFSzAvSXZLSTZJYzRY?=
 =?iso-2022-jp?B?cWdGVjkyUVlYWWlQZDI5LzJMeXdHSVRZT0JDN1Z1eUFIYnZya2R3N3Y1?=
 =?iso-2022-jp?B?MUxjUW04dU5lR01wSWUrcnhWYTVKNE1KcFNWREdYZytxZGwra1paRXRY?=
 =?iso-2022-jp?B?ZGozUEpoMVVXUmNrallsU2Nrbk9sdkVLUFFtRzVkRXM4Mi9xM2Q3ZVg3?=
 =?iso-2022-jp?B?a2JNU1ZkQ0U4dFByalpwUFNxeWY1dkU5L0M5czc4cjRyVElqQlp2Tkdy?=
 =?iso-2022-jp?B?dG94TjlxZmtvMG92SG1wTy8rdlFoWXVMcUZmbnAvVitxOTdmNW9zZWpp?=
 =?iso-2022-jp?B?cFBNUXlrTXNBalRLdENnTlFXRXVQYW8veGU5YTNXRGR6SFBoZTlvNGZt?=
 =?iso-2022-jp?B?SFFyVWlwc3NObVB5TUtYd1ExSXNVN0NnTE1xY3N1ek5IVXVCc3p4Tits?=
 =?iso-2022-jp?B?c05YSVQzWTFLVDJnNXhCTlNTQzBuUnhEZUNDb0YwTVVBa2JCMCtqam9C?=
 =?iso-2022-jp?B?dVJSRmhYTUlZNDhrZ1pVNkpMeWVvQjFRTFVwKzdJMUtXZEcvYzhUZnlq?=
 =?iso-2022-jp?B?NGxwRjdvOWt2STBOMzVzWHorVW50R2NXV01CclBGeURJcVRMYzIzc0JE?=
 =?iso-2022-jp?B?RjY1WENkTnFhcS91TElGMnZjem4zL1VhQnRReEpWVnBud2pXc1BPcDRr?=
 =?iso-2022-jp?B?djBkOTBjWitvam5Za3E0aDVqTldWTndkR29aN09qSmZqVFc2emEwaUVy?=
 =?iso-2022-jp?B?VlpvYVpRRGhSMDVOVUEvQWdBOCtYSml3R2hQMGhZcVEvc3g2Y1lDSUlt?=
 =?iso-2022-jp?B?Z3NvYXFFS1N5WGFWYkpTWDlrRkRZeDlTTXZlYUw1UG80OE4zdjZ4ZEpY?=
 =?iso-2022-jp?B?YkorNWRQZTROa3JqdkVpVzFFbFBYQ0ljRE9JRWN2RzZTMHRyY2hKSjZi?=
 =?iso-2022-jp?B?MVdhc3Q1S1RXelorb2V4U3Y5UTdTSlc5RFZxTHIvUU9QVnM2T2JrbU8v?=
 =?iso-2022-jp?B?NU5Xd3VXMEF1dnRvaVhXQ3lTaHpEcXhPQnc1MXRUeWtubTJmOTNjSXFV?=
 =?iso-2022-jp?B?UWQ0REtzQktTYm90RUk1ZXF0Z1hTa24wOHdULzJIMm5kUndIVHViWXBo?=
 =?iso-2022-jp?B?QXd1WDF1SzRXNVlZZmFuV0N5eWM1eTQwRXUyV0kwN0lkN0ZNNVBzNWRw?=
 =?iso-2022-jp?B?ZXV5Ti9pVkZKUmt6UlFHak1OQWlxOElEdURhOVdJYkVGeDFHT2tPQjhx?=
 =?iso-2022-jp?B?OHc0dTZKT3JnUnpaRTdkYVZDNUFVU1Nmelg3QlVxR1p6ZUpDVDFWQjJY?=
 =?iso-2022-jp?B?R1E3WVNRL0hnNk1jcExCdE5Vd1o3TlJUeUNaamx6czU2eGhZczYxUEM1?=
 =?iso-2022-jp?B?M3pzb1lpRDBQYjJaZkxQcDk4VE50dUovRE9UTjF4VVVFcm9PaE1QREZm?=
 =?iso-2022-jp?B?WWF4eFJoRTJRQzJwK2N4OTJiNXo1cVhQVnoxWFhzMzNQcTBIMW5ER1M3?=
 =?iso-2022-jp?B?bnlMeWdKK2FaR091OGlqL3Q3Wkh6cEJWMFNPUmtFeFhvZzd3dit5NzVT?=
 =?iso-2022-jp?B?c056UWZhK05lWExYbXZ6WUh2MkxwQlF0OVRkeTUvZkZxcUZqYXBiZ2Ev?=
 =?iso-2022-jp?B?aGNWMW5CWTkxT3FvdDNCVHBOZWwzYkJra25vSTZ0S2ZkWlcwYzI1Um5S?=
 =?iso-2022-jp?B?RnRNa2oxV2pObjdCTFZ1MTJuNXpSQTZYU2YwUUh4NXpGTXI0cFNuQUdT?=
 =?iso-2022-jp?B?cUVNbnRqYzBHNFpYMUMxQ25Hek5VejJqMXhkQi9ld0pEc0V3emFGT1FZ?=
 =?iso-2022-jp?B?R29Mdm15OHQ5SStYUFZ0NU11eDg0PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?UUR6SGFsdnZvVkdHWWxOOUFoQ21GdjlFN2diMG82R0JPNTFGZE5aeW1X?=
 =?iso-2022-jp?B?RVNndkNHazhXb0MxS0kzbFNsZUIyQTFNa3VBakt1S0w0Y1VnSEZYVVA4?=
 =?iso-2022-jp?B?WFZRY0ZOVUpaYzdWdCtLY3h2dVRwVXVVejhrT25zQ1lRNnhJTlUrNUFI?=
 =?iso-2022-jp?B?czBVNUtsMnFOMHRTckFMR1RPMWlkdG52aEFHTGtUamJ6YW5aS1gvOG1y?=
 =?iso-2022-jp?B?L3VqK0d3bTdoVGdqOTZHTm5USVBJdXNmMXEyMm1RU05NVUhNdG1CVDZu?=
 =?iso-2022-jp?B?SGJ1a1Ivakt5c1JBUDNhL3R1aEswSEp2S2plSzJPT1FuWkN2QzhuWVky?=
 =?iso-2022-jp?B?V2hyUzhMRS80ckc3dEV6eXlOM1VQYytuV0ZNTHdIZzZkc1JwdHhJNVQx?=
 =?iso-2022-jp?B?QzdVcXovdTJJazdiSHRLSHZ2QVlWcVp1MkVDU29Ka3FzeFN2MmRNcms2?=
 =?iso-2022-jp?B?Y3JCOFhjdVNEMlBYblQzMXJBMDFqM201QUJMaWJqSXV2YnA4NVowU1Vr?=
 =?iso-2022-jp?B?MWpiU0dNV01GSTNxLy9HRVZ1YW52UnlvT0VNQWxRblcwYnlKUHNiUEtS?=
 =?iso-2022-jp?B?TTFXVFBPdmMwR0N1eU5RUUtCWC92Qit4enQ1N20zUGl2VnpyYmlmMDhq?=
 =?iso-2022-jp?B?YnVNUFZRMlY3TWtOS0pxYmkreVNQUUlYTmxseE5pckpmMlExWEltRnNC?=
 =?iso-2022-jp?B?WWlPTloyT1NpNThrQjNpTVVEZGFDZW53c1ZuMTF1dmtrLzBTMVdJN1Y2?=
 =?iso-2022-jp?B?dDVtejRlbUU3MzF2US9DSTd1SVIzY1pTaUVrL1NGTVF3bDZlRmJ6YUsx?=
 =?iso-2022-jp?B?WG9ERStjNmdBUzEzaHBwTkxnMy92N3BIRDdMTzltYjFNQ0JYNlVYOEIv?=
 =?iso-2022-jp?B?NmtsTjgxdDNFUVlYT3lKY2twbUp2dkhLRHdmZkRsQmUyYmpkVWRWc3dY?=
 =?iso-2022-jp?B?RkdvQ3VzVXF0TmtxY1p5alhMbDRkVk1SOG9yK1owbmcxZTNxTjVSZ09a?=
 =?iso-2022-jp?B?dk1FY3dtV293QVhKODJtRHAzNWZJMVNxc0tQRVhzSHFaakk1NlRJU0NU?=
 =?iso-2022-jp?B?OTIxUmRtU2FsYkZZWXVkSFpHSFl6NDg2aVcxR1QwcFlScUc0ZHUrNWxI?=
 =?iso-2022-jp?B?dlVNcHUwK0RYRGtSaG9GaVVLcUU2MjdIWUk3Y3VLbXFhYXV0M3E5KzIy?=
 =?iso-2022-jp?B?K0ZsY3pqTzFlNjJxODdwWGZPUXZCLzhWVGtGRHI5NmVtR1owN0M4QWRH?=
 =?iso-2022-jp?B?bGlsenI2OTF4RFl2ZThlVzJNcWRxZUR4cWN6Umc2dzhTVU1HOURiaHhs?=
 =?iso-2022-jp?B?bDZubHBDakFVTlViakVQZnBJQXg5MFhpMXpiWFlhNmdLZ0JwQ0xSamZL?=
 =?iso-2022-jp?B?SDlQUXY0RFppdVRQOFhBZm83T25UdkZVRUNnNHpUR29KYkpqZDYzekVV?=
 =?iso-2022-jp?B?YXh3MllRNEhXMCtMb1h0MlZpYUtoNmtES1ZqVWszdWMzYThkSGVkbVIr?=
 =?iso-2022-jp?B?Sy9nK3NQN1I5aGRaQi9LK0p3QVBKbG0rdEZjT0JTRTJOVENWMGNrUGdU?=
 =?iso-2022-jp?B?K1lBTnBXMWY4RzBEdW80L05CN2lWVkdkOFgyMVJacXdaa0lrZFhZblU4?=
 =?iso-2022-jp?B?OTdJWURoaW5FcWxOeWhYcHhNNW9hZjJ3M05sYytMT2RxYmpuRkQwN1Zj?=
 =?iso-2022-jp?B?cGY3TEladjBaTGdLRFNKMWFyd0ZwTFlSbzR2UmNrOXN0eDgrSE56SExV?=
 =?iso-2022-jp?B?SWFMQ3pVSTQ4MnUxVTNHVTEzdndUR2RrQmpnTjdWZWVpRXFYaTNwdTVK?=
 =?iso-2022-jp?B?VnlQN3NEQTlkd3NhZEtETTdWLzF2TEhnbmZPL01VWkxrd0xXYWE1Nlhs?=
 =?iso-2022-jp?B?N1NaR1lIaklWSGVXenFnNUdtaHRtYUtXUWdzWGZrRDYwdFZBaTdZTEdW?=
 =?iso-2022-jp?B?SXZCYWRFSVA2cHlLNnB4ZUZaeXV4NklabHBQZjZyWXdKSkdIbzBiOG42?=
 =?iso-2022-jp?B?cFZQaXJYdVdDazRzNUYxQzRobC83ZmNDQXVUU2ZmQ0NycyszWm81ZVVH?=
 =?iso-2022-jp?B?elYzeXlianEyNmM3VTUzYTMzbEs0eFlRTEwrdHJ2QzhTNzZnMXovQWZV?=
 =?iso-2022-jp?B?a1hzYlptTGRWbDJ6aHdmVCswK2JQY3FLTWEwaTQxVW5OczhacHBZZEpD?=
 =?iso-2022-jp?B?MlZsL1pFajY3MVhYeEc5cy8xS3Q1bzBvUUsraUk2YW0wY0wweDU2L0ZQ?=
 =?iso-2022-jp?B?QiswZzVkVjdqdEZ5b0JMc2N2VHNhc1doNXQ5Q1lvbmdIa3Z5OGRQWko3?=
 =?iso-2022-jp?B?Z3VMSnhjejNQVzBBK3U5eTBMV2NNZGw0U0E9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB6103B95D6D38ECAB1BE70F18C2F52OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87fd3730-d491-4c93-30ed-08dc7bc5589e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 07:44:30.4912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 85rOW8AbNXEI1gGiF8Yuldn/rAFWDzV1B3KY02dCIpM0Z1TpsKXRbcYdmAkTsD+KWjanAsu+dPuqYP+P//Wt4UeG9yO+n71UqGjhpcmm1Ic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11057
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 May 2024 07:44:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15941

--_000_OS3PR01MB6103B95D6D38ECAB1BE70F18C2F52OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable


Hi Chris,

I updated the corresponding MR lava-slave/scripts: Add scripts needed to ru=
n for booting CIP QEMU security target (!35) * Merge requests * cip-project=
 / cip-testing / lava-docker * GitLab<https://gitlab.com/cip-project/cip-te=
sting/lava-docker/-/merge_requests/35?commit_id=3D6642a2390ead758ecbb8b096c=
62c4c5d4fd504b3>

This MR only adds the scripts in the workers. Updating device dictionaries =
on only one QEMU device in each worker has to be done manually.

If you have further review comments, please provide them in the MR.

Thanks and regards,
Sai Ashrith Sathujoda (T S I P)
From: Chris Paterson <Chris.Paterson2@renesas.com>
Sent: Thursday, May 23, 2024 8:04 PM
To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>
Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshib=
a-tsip.com>; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =
=1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>; jan.=
kiszka@siemens.com
Subject: RE: Request for updating device dictionaries

Hello Sai,

I can update the device dictionaries, however each lab would need to update=
 it=1B$B!G=1B(Bs worker docker image to include the swtpm*.sh scripts.
Before we do this, we should really finish and merge the corresponding MR: =
https://gitlab.com/cip-project/cip-testing/lava-docker/-/merge_requests/35/
Please could you check the remaining threads?
Once merged I=1B$B!G=1B(Bll ask for each of the workers to be upgraded (I o=
nly have access to my own worker).

I=1B$B!G=1B(Bll remove the swtpm-jobs tags I added the other day, so at lea=
st your pipelines don=1B$B!G=1B(Bt fail - they=1B$B!G=1B(Bll just run slowe=
r.

Thanks, Chris

From: Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>=
 <Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>>
Sent: Tuesday, May 21, 2024 12:05 PM
To: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@rene=
sas.com>>
Cc: dinesh.kumar@toshiba-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>; ka=
zuhiro3.hayashi@toshiba.co.jp<mailto:kazuhiro3.hayashi@toshiba.co.jp>; jan.=
kiszka@siemens.com<mailto:jan.kiszka@siemens.com>
Subject: RE: Request for updating device dictionaries

Hi Chris,

Thank you so much for adding the tags to one qemu for each worker. But the =
device dictionaries for these tagged devices need to be updated with the be=
low snippet. Without these changes we cannot boot the security image in LAV=
A.

{% set user_commands =3D {'start_tpm': {'do':'"/usr/bin/sh /usr/local/bin/s=
wtpm_start.sh"',

                                      'undo':'"/usr/bin/sh /usr/local/bin/s=
wtpm_finish.sh"' },

                        'manual_kill': {'do':'"/usr/bin/pkill -15 swtpm"'}}=
 %}

Just like it is updated for this device LAVA | Scheduler | Devices | qemu-r=
enesas-01 | dictionary (ciplatform.org)<https://lava.ciplatform.org/schedul=
er/device/qemu-renesas-01/devicedict> .

Can you kindly update the device dictionaries for the below =1B$B!H=1B(Bswt=
pm-jobs=1B$B!I=1B(B tagged devices ?


  *   https://lava.ciplatform.org/scheduler/device/qemu-03
  *   https://lava.ciplatform.org/scheduler/device/qemu-cip-siemens-muc
  *   https://lava.ciplatform.org/scheduler/device/qemu-patersonc-01

I will contact the maintainers of isar-cip-core project regarding CI/CD var=
iables.

Thanks and regards,
Sai Ashrith Sathujoda (T S I P)



From: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@re=
nesas.com>>
Sent: Tuesday, May 21, 2024 4:24 PM
To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com<mailto:=
Sai.Sathujoda@toshiba-tsip.com>>
Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshib=
a-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>>; hayashi kazuhiro(=1B$BNS=
=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <=
kazuhiro3.hayashi@toshiba.co.jp<mailto:kazuhiro3.hayashi@toshiba.co.jp>>; j=
an.kiszka@siemens.com<mailto:jan.kiszka@siemens.com>
Subject: RE: Request for updating device dictionaries

Hello Sai,

You need to talk to the maintainers of the isar-cip-core project to get CI/=
CD variables set there. It=1B$B!G=1B(Bs not my project so I shouldn=1B$B!G=
=1B(Bt make such changes.

I=1B$B!G=1B(Bve added the swtpm-jobs tag to one qemu from each worker. Chec=
k the =1B$B!H=1B(Bgreen eye=1B$B!I=1B(B on the right of this page: https://=
lava.ciplatform.org/scheduler/device_type/qemu

Kind regards, Chris

From: Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>=
 <Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>>
Sent: Monday, May 20, 2024 11:23 AM
To: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@rene=
sas.com>>
Cc: cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>; di=
nesh.kumar@toshiba-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>; kazuhiro=
3.hayashi@toshiba.co.jp<mailto:kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: Request for updating device dictionaries

Hello Chris,

Any updates on 2nd and 3rd requests I made in the below mail ?

Thanks and regards,
Sai Ashrith Sathujoda (T S I P)

From: ashrith sai(=1B$B#T#S#I#P=1B(B)
Sent: Wednesday, May 15, 2024 4:41 PM
To: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@rene=
sas.com>>
Cc: cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>; di=
nesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshiba-tsip=
.com<mailto:dinesh.kumar@toshiba-tsip.com>>; hayashi kazuhiro(=1B$BNS=1B(B =
=1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhi=
ro3.hayashi@toshiba.co.jp<mailto:kazuhiro3.hayashi@toshiba.co.jp>>
Subject: Request for updating device dictionaries

Hello Chris,

Hope you are doing well.

Sorry to disturb you with these extra things I need on CIP LAVA Lab. Let me=
 consolidate my requests in this mail.

I am preparing a patch to trigger LAVA job definitions from isar-cip-core. =
Currently I am working on that in a custom branch. Before sending that patc=
h, I have created an MR to update the cip-core-ci repository which is requi=
red to run the test jobs in isar-cip-core. I will assign it for your review=
 soon.

I will be able to send the patch to add test jobs in isar-cip-core once the=
 below mentioned things are done.

  1.  This MR needs to merge build-bookworm.Dockerfile: Include lava.sh and=
 templates in the docker image. (!3) * Merge requests * cip-playground / ci=
p-core-ci * GitLab<https://gitlab.com/cip-playground/cip-core-ci/-/merge_re=
quests/3> which I shall assign to you soon after some internal review.
  2.  I need some variables in isar-cip-core CI/CD setting section like LAV=
A_USER, LAVA_TOKEN and SQUAD_TOKEN. We don=1B$B!G=1B(Bt have the privilege =
to do that. I will mail them to you personally. Please hide them in isar-ci=
p-core Gitlab CI/CD section so that I can use them while running lava.sh sc=
ript.
  3.  Since we need to run these LAVA jobs when pipelines are triggered in =
isar-cip-core, I am making changes in such a way that pipeline keeps runnin=
g until all the jobs are done and we report the health as a result. It will=
 take around 120 mins to run all the jobs. We have only device (qemu-renesa=
-01) under lab-cip-renesas. So, I request you to please add the swtpm devic=
e dictionary changes and swtpm-jobs tag to only one QEMU device in every LA=
VA lab you can access. By this will be able to reduce the pipeline run-time=
 due to simultaneous runs.

It will be very helpful if you provide your support with the above-mentione=
d items.

Thanks and regards,
Sai Ashrith Sathujoda (T S I P)

--_000_OS3PR01MB6103B95D6D38ECAB1BE70F18C2F52OS3PR01MB6103jpnp_
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
	{font-family:Helvetica;
	panose-1:2 11 6 4 2 2 2 2 2 4;}
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:PMingLiU;
	panose-1:2 1 6 1 0 1 1 1 1 1;}
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
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:"\@MS PGothic";}
@font-face
	{font-family:"\@Gulim";
	panose-1:2 11 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:"\@PMingLiU";
	panose-1:2 1 6 1 0 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:JA;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:JA;}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
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
	{mso-list-id:512649885;
	mso-list-type:hybrid;
	mso-list-template-ids:-1842836820 67698689 67698691 67698693 67698689 6769=
8691 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l1
	{mso-list-id:840051443;
	mso-list-template-ids:-1060755896;}
@list l2
	{mso-list-id:1048912660;
	mso-list-template-ids:-60548064;}
@list l2:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3
	{mso-list-id:1959749534;
	mso-list-type:hybrid;
	mso-list-template-ids:-1796337264 67698703 -1 -1 -1 -1 -1 -1 -1 -1;}
@list l3:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:1.25in;
	text-indent:-.25in;}
@list l3:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:1.75in;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l3:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:2.25in;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l3:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:2.75in;
	text-indent:-.25in;
	font-family:Symbol;}
@list l3:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:3.25in;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l3:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:3.75in;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l3:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:4.25in;
	text-indent:-.25in;
	font-family:Symbol;}
@list l3:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:4.75in;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l3:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:5.25in;
	text-indent:-.25in;
	font-family:Wingdings;}
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
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Hi Chris,=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">I updated=
 the corresponding MR
</span><a href=3D"https://gitlab.com/cip-project/cip-testing/lava-docker/-/=
merge_requests/35?commit_id=3D6642a2390ead758ecbb8b096c62c4c5d4fd504b3">lav=
a-slave/scripts: Add scripts needed to run for booting CIP QEMU security ta=
rget (!35) &middot; Merge requests &middot; cip-project
 / cip-testing / lava-docker &middot; GitLab</a> <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">This MR only adds the scripts in the workers. Updati=
ng device dictionaries on only one QEMU device in each worker has to be don=
e manually.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">If you have further review comments, please provide =
them in the MR.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks and regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Sai Ashrith Sathujoda (T S I P)<span style=3D"mso-fa=
reast-language:EN-US"><o:p></o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Calibri&quot;,sa=
ns-serif;mso-ligatures:none;mso-fareast-language:ZH-TW">From:</span></b><sp=
an style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;m=
so-fareast-language:ZH-TW"> Chris Paterson &lt;Chris.Paterson2@renesas.com&=
gt;
<br>
<b>Sent:</b> Thursday, May 23, 2024 8:04 PM<br>
<b>To:</b> ashrith sai(</span><span lang=3D"ZH-TW" style=3D"font-family:&qu=
ot;PMingLiU&quot;,serif;mso-ligatures:none;mso-fareast-language:ZH-TW">=1B$=
B#T#S#I#P=1B(B</span><span style=3D"font-family:&quot;Calibri&quot;,sans-se=
rif;mso-ligatures:none;mso-fareast-language:ZH-TW">) &lt;Sai.Sathujoda@tosh=
iba-tsip.com&gt;<br>
<b>Cc:</b> dinesh kumar(</span><span lang=3D"ZH-TW" style=3D"font-family:&q=
uot;PMingLiU&quot;,serif;mso-ligatures:none;mso-fareast-language:ZH-TW">=1B=
$B#T#S#I#P=1B(B</span><span style=3D"font-family:&quot;Calibri&quot;,sans-s=
erif;mso-ligatures:none;mso-fareast-language:ZH-TW"> TMIEC ODG Porting)
 &lt;dinesh.kumar@toshiba-tsip.com&gt;; hayashi kazuhiro(</span><span lang=
=3D"ZH-TW" style=3D"font-family:&quot;PMingLiU&quot;,serif;mso-ligatures:no=
ne;mso-fareast-language:ZH-TW">=1B$BNS=1B(B</span><span lang=3D"ZH-TW" styl=
e=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-fare=
ast-language:ZH-TW">
</span><span lang=3D"ZH-TW" style=3D"font-family:&quot;PMingLiU&quot;,serif=
;mso-ligatures:none;mso-fareast-language:ZH-TW">=1B$BOB9(=1B(B</span><span =
lang=3D"ZH-TW" style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-liga=
tures:none;mso-fareast-language:ZH-TW">
</span><span lang=3D"ZH-TW" style=3D"font-family:&quot;PMingLiU&quot;,serif=
;mso-ligatures:none;mso-fareast-language:ZH-TW">=1B$B#D#M#E=1B(B</span><spa=
n style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;ms=
o-fareast-language:ZH-TW"> =1B$B!{=1B(B</span><span lang=3D"ZH-TW" style=3D=
"font-family:&quot;PMingLiU&quot;,serif;mso-ligatures:none;mso-fareast-lang=
uage:ZH-TW">=1B$B#D#I#G=1B(B</span><span style=3D"font-family:&quot;Calibri=
&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:ZH-TW">=1B$B""=1B=
(B</span><span lang=3D"ZH-TW" style=3D"font-family:&quot;PMingLiU&quot;,ser=
if;mso-ligatures:none;mso-fareast-language:ZH-TW">=1B$B#M#P#S=1B(B</span><s=
pan style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;=
mso-fareast-language:ZH-TW">=1B$B!{=1B(B</span><span lang=3D"ZH-TW" style=
=3D"font-family:&quot;PMingLiU&quot;,serif;mso-ligatures:none;mso-fareast-l=
anguage:ZH-TW">=1B$B#M#P#4=1B(B</span><span style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:ZH-TW">)
 &lt;kazuhiro3.hayashi@toshiba.co.jp&gt;; jan.kiszka@siemens.com<br>
<b>Subject:</b> RE: Request for updating device dictionaries<o:p></o:p></sp=
an></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Hello Sai,<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;<=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">I can update=
 the device dictionaries, however each lab would need to update it=1B$B!G=
=1B(Bs worker docker image to include the swtpm*.sh scripts.<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Before we do=
 this, we should really finish and merge the corresponding MR:
<a href=3D"https://gitlab.com/cip-project/cip-testing/lava-docker/-/merge_r=
equests/35/">
https://gitlab.com/cip-project/cip-testing/lava-docker/-/merge_requests/35/=
</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Please could=
 you check the remaining threads?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Once merged =
I=1B$B!G=1B(Bll ask for each of the workers to be upgraded (I only have acc=
ess to my own worker).<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;<=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">I=1B$B!G=1B(=
Bll remove the swtpm-jobs tags I added the other day, so at least your pipe=
lines don=1B$B!G=1B(Bt fail &#8211; they=1B$B!G=1B(Bll just run slower.<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;<=
/o:p></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-liga=
tures:none;mso-fareast-language:EN-GB">Thanks, Chris<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;<=
/o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Calibri&quot;,sa=
ns-serif;mso-ligatures:none;mso-fareast-language:KO">From:</span></b><span =
style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-=
fareast-language:KO">
<a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujoda@toshiba-tsi=
p.com</a> &lt;<a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujo=
da@toshiba-tsip.com</a>&gt;
<br>
<b>Sent:</b> Tuesday, May 21, 2024 12:05 PM<br>
<b>To:</b> Chris Paterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com=
">Chris.Paterson2@renesas.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar@to=
shiba-tsip.com</a>;
<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@toshib=
a.co.jp</a>;
<a href=3D"mailto:jan.kiszka@siemens.com">jan.kiszka@siemens.com</a><br>
<b>Subject:</b> RE: Request for updating device dictionaries<o:p></o:p></sp=
an></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Hi Chris,=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Thank you=
 so much for adding the tags to one qemu for each worker. But the device di=
ctionaries for these tagged devices need to be updated with the below snipp=
et. Without these changes we cannot
 boot the security image in LAVA.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
10.5pt;font-family:&quot;Courier New&quot;;color:#333333">{% set user_comma=
nds =3D {'start_tpm': {'do':'&quot;/usr/bin/sh /usr/local/bin/swtpm_start.s=
h&quot;',</span><span style=3D"font-size:10.5pt;font-family:&quot;Helvetica=
&quot;,sans-serif;color:#333333;mso-ligatures:none;mso-fareast-language:EN-=
US"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
10.5pt;font-family:&quot;Helvetica&quot;,sans-serif;color:#333333"><o:p>&nb=
sp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
10.5pt;font-family:&quot;Courier New&quot;;color:#333333">&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'undo':'&quot;/usr/=
bin/sh /usr/local/bin/swtpm_finish.sh&quot;' },</span><span style=3D"font-s=
ize:10.5pt;font-family:&quot;Helvetica&quot;,sans-serif;color:#333333"><o:p=
></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
10.5pt;font-family:&quot;Helvetica&quot;,sans-serif;color:#333333"><o:p>&nb=
sp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
10.5pt;font-family:&quot;Courier New&quot;;color:#333333">&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'manual_kill': {'do':'&quot;=
/usr/bin/pkill -15 swtpm&quot;'}} %}<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
10.5pt;font-family:&quot;Courier New&quot;;color:#333333"><o:p>&nbsp;</o:p>=
</span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#333=
333">Just like it is updated for this device
</span><span style=3D"color:black"><a href=3D"https://lava.ciplatform.org/s=
cheduler/device/qemu-renesas-01/devicedict">LAVA | Scheduler | Devices | qe=
mu-renesas-01 | dictionary (ciplatform.org)</a> .
</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"background:white"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:blac=
k">Can you kindly update the device dictionaries for the below =1B$B!H=1B(B=
swtpm-jobs=1B$B!I=1B(B tagged devices ?</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"background:white"><o:p>&nbsp;</o:p></p>
<ul style=3D"margin-top:0in" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1 =
lfo3;background:white">
<span style=3D"color:#333333"><a href=3D"https://lava.ciplatform.org/schedu=
ler/device/qemu-03">https://lava.ciplatform.org/scheduler/device/qemu-03</a=
></span><o:p></o:p></li><li class=3D"MsoListParagraph" style=3D"margin-left=
:0in;mso-list:l0 level1 lfo3;background:white">
<span style=3D"color:#333333"><a href=3D"https://lava.ciplatform.org/schedu=
ler/device/qemu-cip-siemens-muc">https://lava.ciplatform.org/scheduler/devi=
ce/qemu-cip-siemens-muc</a></span><o:p></o:p></li><li class=3D"MsoListParag=
raph" style=3D"margin-left:0in;mso-list:l0 level1 lfo3;background:white">
<span style=3D"color:#333333"><a href=3D"https://lava.ciplatform.org/schedu=
ler/device/qemu-patersonc-01">https://lava.ciplatform.org/scheduler/device/=
qemu-patersonc-01</a></span><o:p></o:p></li></ul>
<p class=3D"MsoNormal" style=3D"background:white"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:blac=
k">I will contact the maintainers of isar-cip-core project regarding CI/CD =
variables.</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"background:white"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:blac=
k">Thanks and regards,</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:blac=
k">Sai Ashrith Sathujoda (T S I P)</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#333=
333"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Calibri&quot;,sa=
ns-serif;mso-ligatures:none;mso-fareast-language:KO">From:</span></b><span =
style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-=
fareast-language:KO"> Chris Paterson &lt;<a href=3D"mailto:Chris.Paterson2@=
renesas.com">Chris.Paterson2@renesas.com</a>&gt;
<br>
<b>Sent:</b> Tuesday, May 21, 2024 4:24 PM<br>
<b>To:</b> ashrith sai(</span><span lang=3D"KO" style=3D"font-family:&quot;=
Gulim&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:KO">=1B$B#T#=
S#I#P=1B(B</span><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;=
mso-ligatures:none;mso-fareast-language:KO">) &lt;<a href=3D"mailto:Sai.Sat=
hujoda@toshiba-tsip.com">Sai.Sathujoda@toshiba-tsip.com</a>&gt;<br>
<b>Cc:</b> dinesh kumar(</span><span lang=3D"KO" style=3D"font-family:&quot=
;Gulim&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:KO">=1B$B#T=
#S#I#P=1B(B</span><span lang=3D"KO" style=3D"font-family:&quot;Calibri&quot=
;,sans-serif;mso-ligatures:none;mso-fareast-language:KO">
</span><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatu=
res:none;mso-fareast-language:KO">TMIEC ODG Porting) &lt;<a href=3D"mailto:=
dinesh.kumar@toshiba-tsip.com">dinesh.kumar@toshiba-tsip.com</a>&gt;; hayas=
hi kazuhiro(</span><span lang=3D"KO" style=3D"font-family:&quot;Gulim&quot;=
,sans-serif;mso-ligatures:none;mso-fareast-language:KO">=1B$BNS=1B(B</span>=
<span lang=3D"KO" style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-l=
igatures:none;mso-fareast-language:KO">
</span><span lang=3D"KO" style=3D"font-family:&quot;Gulim&quot;,sans-serif;=
mso-ligatures:none;mso-fareast-language:KO">=1B$BOB9(=1B(B</span><span lang=
=3D"KO" style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:n=
one;mso-fareast-language:KO">
</span><span lang=3D"KO" style=3D"font-family:&quot;Gulim&quot;,sans-serif;=
mso-ligatures:none;mso-fareast-language:KO">=1B$B#D#M#E=1B(B</span><span st=
yle=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-fa=
reast-language:KO"> =1B$B!{=1B(B</span><span lang=3D"KO" style=3D"font-fami=
ly:&quot;Gulim&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:KO"=
>=1B$B#D#I#G=1B(B</span><span style=3D"font-family:&quot;Calibri&quot;,sans=
-serif;mso-ligatures:none;mso-fareast-language:KO">=1B$B""=1B(B</span><span=
 lang=3D"KO" style=3D"font-family:&quot;Gulim&quot;,sans-serif;mso-ligature=
s:none;mso-fareast-language:KO">=1B$B#M#P#S=1B(B</span><span style=3D"font-=
family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-langua=
ge:KO">=1B$B!{=1B(B</span><span lang=3D"KO" style=3D"font-family:&quot;Guli=
m&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:KO">=1B$B#M#P#4=
=1B(B</span><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-l=
igatures:none;mso-fareast-language:KO">)
 &lt;<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@t=
oshiba.co.jp</a>&gt;;
<a href=3D"mailto:jan.kiszka@siemens.com">jan.kiszka@siemens.com</a><br>
<b>Subject:</b> RE: Request for updating device dictionaries<o:p></o:p></sp=
an></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Hello Sai,<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;<=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">You need to =
talk to the maintainers of the isar-cip-core project to get CI/CD variables=
 set there. It=1B$B!G=1B(Bs not my project so I shouldn=1B$B!G=1B(Bt make
 such changes.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;<=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">I=1B$B!G=1B(=
Bve added the swtpm-jobs tag to one qemu from each worker. Check the =1B$B!=
H=1B(Bgreen eye=1B$B!I=1B(B on the right of this page:
<a href=3D"https://lava.ciplatform.org/scheduler/device_type/qemu">https://=
lava.ciplatform.org/scheduler/device_type/qemu</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;<=
/o:p></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-liga=
tures:none;mso-fareast-language:EN-GB">Kind regards, Chris<o:p></o:p></span=
></p>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;<=
/o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Calibri&quot;,sa=
ns-serif;mso-ligatures:none;mso-fareast-language:KO">From:</span></b><span =
style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-=
fareast-language:KO">
<a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujoda@toshiba-tsi=
p.com</a> &lt;<a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujo=
da@toshiba-tsip.com</a>&gt;
<br>
<b>Sent:</b> Monday, May 20, 2024 11:23 AM<br>
<b>To:</b> Chris Paterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com=
">Chris.Paterson2@renesas.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.c=
ip-project.org</a>;
<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar@toshiba-tsip.=
com</a>;
<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@toshib=
a.co.jp</a><br>
<b>Subject:</b> RE: Request for updating device dictionaries<o:p></o:p></sp=
an></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Hello Chr=
is,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Any updat=
es on 2<sup>nd</sup> and 3<sup>rd</sup> requests I made in the below mail ?=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Thanks an=
d regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Sai Ashri=
th Sathujoda (T S I P)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Calibri&quot;,sa=
ns-serif;mso-ligatures:none">From:</span></b><span style=3D"font-family:&qu=
ot;Calibri&quot;,sans-serif;mso-ligatures:none"> ashrith sai(</span><span l=
ang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-ligat=
ures:none">=1B$B#T#S#I#P=1B(B</span><span style=3D"font-family:&quot;Calibr=
i&quot;,sans-serif;mso-ligatures:none">)
<br>
<b>Sent:</b> Wednesday, May 15, 2024 4:41 PM<br>
<b>To:</b> Chris Paterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com=
">Chris.Paterson2@renesas.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.c=
ip-project.org</a>; dinesh kumar(</span><span lang=3D"JA" style=3D"font-fam=
ily:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none">=1B$B#T#S#I#P=1B(=
B</span><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligat=
ures:none">
 TMIEC ODG Porting) &lt;<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">di=
nesh.kumar@toshiba-tsip.com</a>&gt;; hayashi kazuhiro(</span><span lang=3D"=
JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:no=
ne">=1B$BNS=1B(B</span><span lang=3D"JA" style=3D"font-family:&quot;Calibri=
&quot;,sans-serif;mso-ligatures:none">
</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-s=
erif;mso-ligatures:none">=1B$BOB9(=1B(B</span><span lang=3D"JA" style=3D"fo=
nt-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none">
</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-s=
erif;mso-ligatures:none">=1B$B#D#M#E=1B(B</span><span style=3D"font-family:=
&quot;Calibri&quot;,sans-serif;mso-ligatures:none"> =1B$B!{=1B(B</span><spa=
n lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-li=
gatures:none">=1B$B#D#I#G=1B(B</span><span style=3D"font-family:&quot;Calib=
ri&quot;,sans-serif;mso-ligatures:none">=1B$B""=1B(B</span><span lang=3D"JA=
" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none=
">=1B$B#M#P#S=1B(B</span><span style=3D"font-family:&quot;Calibri&quot;,san=
s-serif;mso-ligatures:none">=1B$B!{=1B(B</span><span lang=3D"JA" style=3D"f=
ont-family:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none">=1B$B#M#P#=
4=1B(B</span><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-=
ligatures:none">)
 &lt;<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@t=
oshiba.co.jp</a>&gt;<br>
<b>Subject:</b> Request for updating device dictionaries<o:p></o:p></span><=
/p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hello Chris,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hope you are doing well.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Sorry to disturb you with these extra things I need =
on CIP LAVA Lab. Let me consolidate my requests in this mail.<o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am preparing a patch to trigger LAVA job definitio=
ns from isar-cip-core. Currently I am working on that in a custom branch. B=
efore sending that patch, I have created an MR to update the cip-core-ci re=
pository which is required to run
 the test jobs in isar-cip-core. I will assign it for your review soon.<o:p=
></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.25in"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I will be able to send the patch to add test jobs in=
 isar-cip-core once the below mentioned things are done.
<o:p></o:p></p>
<ol style=3D"margin-top:0in" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:.75in;mso-list:l3 level=
1 lfo6">This MR needs to merge
<a href=3D"https://gitlab.com/cip-playground/cip-core-ci/-/merge_requests/3=
">build-bookworm.Dockerfile: Include lava.sh and templates in the docker im=
age. (!3) &middot; Merge requests &middot; cip-playground / cip-core-ci &mi=
ddot; GitLab</a> which I shall assign to you soon after
 some internal review.<o:p></o:p></li><li class=3D"MsoListParagraph" style=
=3D"margin-left:.75in;mso-list:l3 level1 lfo6">I need some variables in isa=
r-cip-core CI/CD setting section like LAVA_USER, LAVA_TOKEN and SQUAD_TOKEN=
. We don=1B$B!G=1B(Bt have the privilege to do that. I will mail them to yo=
u personally.
 Please hide them in isar-cip-core Gitlab CI/CD section so that I can use t=
hem while running lava.sh script.<o:p></o:p></li><li class=3D"MsoListParagr=
aph" style=3D"margin-left:.75in;mso-list:l3 level1 lfo6">Since we need to r=
un these LAVA jobs when pipelines are triggered in isar-cip-core, I am maki=
ng changes in such a way that pipeline keeps running until all the jobs are=
 done and
 we report the health as a result. It will take around 120 mins to run all =
the jobs. We have only device (qemu-renesa-01) under lab-cip-renesas. So, I=
 request you to please add the swtpm device dictionary changes and
<b>swtpm-jobs</b> tag to <b><i>only one</i></b> QEMU device in every LAVA l=
ab you can access. By this will be able to reduce the pipeline run-time due=
 to simultaneous runs.<o:p></o:p></li></ol>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">It will be very helpful if you provide your support =
with the above-mentioned items.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks and regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Sai Ashrith Sathujoda (T S I P)<o:p></o:p></p>
</div>
</div>
</div>
</body>
</html>

--_000_OS3PR01MB6103B95D6D38ECAB1BE70F18C2F52OS3PR01MB6103jpnp_--


