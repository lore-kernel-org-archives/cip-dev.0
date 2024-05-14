Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A09C04FFE
	for <webhook@archiver.kernel.org>; Tue, 14 May 2024 13:24:04 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.15439.1715693041834584867
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 May 2024 06:24:02 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 44EDO04d1292421; Tue, 14 May 2024 22:24:00 +0900
X-Iguazu-Qid: 2yAbrn6vFgwCfUSkE5
X-Iguazu-QSIG: v=2; s=0; t=1715693039; q=2yAbrn6vFgwCfUSkE5; m=iQaVLqmHOP5upUTeaGip1brNN83FskB5SsE21Dl1lqY=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 44EDNwS82941395
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 22:23:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCiW1Or4wteID0Ol8oS3GPG++2T4GFeaqfSCwjkEy46zORD4C1udIWtR1sBR7j/P40r2eluo2lcbIw9G+aDhQ20Zl+Cd3Ji+mfT5vvQuXAEy0NF4M3QY8kMMYK40VzWU9/YL/BKpVnT/v9uRawbcBK/FOE0ES8Z+LsW0v6EO1onALyiBefgtnimfnsiY6gpcsuZJOZc3gvCqmVUcPCaHBTFnRdhSK/6LGsg1vm7CQku4ZIgvMlxT1skENAyeU0CeSkcWktTt65wlhhXtqiTNaVhfyeZ8DH64y+n5KZQUc+DK1fUCHGd9ayeryX1eoXWSngNCeBJ8PiakklK82bL08w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfVx6OTZVIgDLcG6OGef6/2m7+LTIbuh+d+ETrA9ZPM=;
 b=LHJ6ueh3GMT0TWHVXHm1nPYCfoiy3xFlmG0uZE/kaXeEiBoWIyEP/MTdbnREYOxOfNO0IkA/ExXVhSYSG1KrQWsInhQMC3kt2GunqTtUAcYyMgqD1obPO1v+R1nqO7Qsmv9OSeOpPxQOuCaS57isx7hz9nwP9hSmiEZUTXM1YDqX55W61KCgMnbitfg7erMNTe6PgnVasuiQU5wuJ7SKHgfkxYuo6eObHIYAIsF7C0AsaCunQmv3Yj6F9GiERpmpZqpWjvIU9L9oQeNVvRDYziUtzk5xIA0nUkBYa+iqFN/DAx9NYpFzfmuRj4UUmjp8MEhQi0Jxx87/U0V6mcljCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <cip-dev@lists.cip-project.org>, <dinesh.kumar@toshiba-tsip.com>
Subject: RE: Query regarding SQUAD watch job submission
Thread-Topic: Query regarding SQUAD watch job submission
Thread-Index: Adqciz/XU7pqriezQs2bbbOHPjbwrwFpC16QAPRlDgAAABsxQA==
Date: Tue, 14 May 2024 13:23:55 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB61034389AED55C3BDF3D082CC2E32@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: 
 <OS0PR01MB6100BB4B8D14EC6E9527AD68C2182@OS0PR01MB6100.jpnprd01.prod.outlook.com>
 <OS3PR01MB61038D732173B9974298157EC2E62@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYWPR01MB1186205A8C7B706EA3BD3E664B7E32@TYWPR01MB11862.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYWPR01MB1186205A8C7B706EA3BD3E664B7E32@TYWPR01MB11862.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TYCPR01MB6095:EE_
x-ms-office365-filtering-correlation-id: 2870feaf-8d6e-489b-59da-08dc74191ae6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?eHB5V04yZkpZM1VNaGxzaXVQMU0yWW5uSS9wSGdIUXdPQU9ldkJ1ZjB2?=
 =?iso-2022-jp?B?QUlFRk9hZHVQbmpDc0dQREs2UXpQcy83aVFpcExPWnZOU2t2THp5WlpV?=
 =?iso-2022-jp?B?UUhXYnA0TnJEcWlGY1Yyb2NHUm5pMnp2QmdkUWtkZ3crOVBkdDg1REpC?=
 =?iso-2022-jp?B?SlVZeEtFOHV2U1dxZmI1SVNnb3lOZktUUUdqS1hGL1MxYmJDZFYrb1FH?=
 =?iso-2022-jp?B?bzljeXZsbjhsRGRXNTRpRFF4NXh3SHgxS0g3dDRYbXFGVHpTVlNFN3ZV?=
 =?iso-2022-jp?B?YXFKeVN6bEVleFZ0WFpMdlk3NzZPRjBwTlpuV3FXaHhLVXd2SFg1WW9q?=
 =?iso-2022-jp?B?TWJGQ2Ywcnh2TmREV0ttQkgwTDJoWmtTUkdWN3NOWlFPa1YyQ0IvUXNR?=
 =?iso-2022-jp?B?bHpKWWpVY3VqYnllWTh0eWs4SGVnWXd5VnZadXdFTEI3WnpzNHpJUmpC?=
 =?iso-2022-jp?B?VUxFdjhrVDJXWEJuNTVLNll1YUJmRmpOSmxNQmRWT0V4czYwd2k1cmpW?=
 =?iso-2022-jp?B?eGFmTGhFeGQ0UlQrQUhmM3F3Y2M4bHlES0FMamNQYmE1cVc1MXhUUC9C?=
 =?iso-2022-jp?B?Z1o2cmJ5S2JwRnZHOXAxR3pnL3Qza1BsZ1lnTmpoazZvZ3lIN0dEcEhB?=
 =?iso-2022-jp?B?KzBmWTRuTHBYTks0U0RrbStOUXdRWGZwVUlQRWY4RXRsWEt4WVd0QzlX?=
 =?iso-2022-jp?B?anZCVTlkNTZLK2xWbHVFNXk1WUd5Z203R2NxeDUvV3QxZTVVa054dE11?=
 =?iso-2022-jp?B?c3d6UmhaYTJBVGwzTGtyb0h1Z3RGNWNoMmUrNmNQV1lCajlXaE9BK1Ay?=
 =?iso-2022-jp?B?M1NWYzQrRXRpekV1dEk5dktMeVBUWU9rTzdTWXFpbWFmOGh2MUU5UW5s?=
 =?iso-2022-jp?B?TUdSQ2d1ZERoNXE2UG1FUDRjdWdoemtsNVJGUTdrc1ZpVldmcm9ib1pH?=
 =?iso-2022-jp?B?Q2NsNVdJOXFZR1NhdDlYMFNNeDJFTkFFYVd1ajhhOTRibm14M0dmeFVZ?=
 =?iso-2022-jp?B?Q1IvcVR2ektCVVZxUXFadkdOTHRUNitpbFpveEp6L3ErbjdDeHlnckJw?=
 =?iso-2022-jp?B?UDRyTytmSGZBNXJ1L1pFYjdiRnErWGxManBtQXZkVENFK29wMXMzU3Nt?=
 =?iso-2022-jp?B?TUZ4bmpCNkczekhtemFmU2JrdkQ1MUR2S01NUnlEYlJzTnEwZDdLWHAy?=
 =?iso-2022-jp?B?VW5FVnZWYVdNZnhTY1drRU1SajliQWpwcHBvQ1VBUE82N0I3Qk56QkEz?=
 =?iso-2022-jp?B?RWZXa1J1N3ZsU1lQSm5tVzhxcmRrYm4rMlFvc3MwSlhlaGY4N2ZPK1BI?=
 =?iso-2022-jp?B?WHB5YWtqcEUwOU9rUGJpTmVyR1c3YTlsdmQwa2RaQjJ2SGI0N3VwNHAx?=
 =?iso-2022-jp?B?S2ZaMjduU0ViY3Bqc2hJT3FOcTFsL2xzRzdVbndiV25FMVhKY3l2T1Rs?=
 =?iso-2022-jp?B?U2NBMGVIS2ljY0VteEsrdUx6azdRWWF1S2N0UVFTSktjdGhFL0plMzJo?=
 =?iso-2022-jp?B?b0FHZEdNdlNpeEJra1lRdjBTNnJUazJkbTYvVVRKa2JXemkyQU9PRTIy?=
 =?iso-2022-jp?B?dXdEemUxeUlqN3ZGODJERzhidnRYeEhIbzh6b2YzVENua0JZelQ3dUdo?=
 =?iso-2022-jp?B?c1U3OWR6eWM3ajU1RExjajNZL0pQUklmUXk5VUNpMjRQN2hRc2RTRGla?=
 =?iso-2022-jp?B?emQ4S0hBQVcxRXg2N09EYnp0dWpVNHF0UXFHZ1VJRHhOWUpKQnNNWXJ5?=
 =?iso-2022-jp?B?aEMvQkpBTkxLR2xBZ28xNldzYWU5SmRjNkFDSHFaT0Zlci94ZnVncGk5?=
 =?iso-2022-jp?B?YTZXQmVESWQ1S1dhYnJtcW1hS0lOczJHTG5LVjhxV1B6ZWVYTEc0NEFx?=
 =?iso-2022-jp?B?ckFyS2UrYkU3ZFJJYjZxNVdsZWdvPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?eHVCWEpaeUQvUjZ3R2FRVThyQmw5b09HLzgyTUZpcXFGVXExd1lpU3B1?=
 =?iso-2022-jp?B?R3lRRGRaK0dNQlRqK1BwSTJtMVRPYWNmb0FmcUdhMkpXc0pIOXhMYVVF?=
 =?iso-2022-jp?B?K0JOSmNFV2FnZVh5c1FpdktSK0d6dEI2N1FOUzBZNWEwc0pjd2NFYzlp?=
 =?iso-2022-jp?B?V3JKL1pxNUxBMzJEUXhRbnR2N3pGTHdDUHVyYlFDc0tVRFQyWkNYWEFW?=
 =?iso-2022-jp?B?QmRGY2dyRlZIRXA2MHZSVTZHeC9FRmt1Nk03b1g3MFhtUFJLRzVPYzFF?=
 =?iso-2022-jp?B?Q09ycC9rd01SamVaeVdKWVFaLy9Cc0ZVQStVcEQ1c1pCc2IzUThpbHB0?=
 =?iso-2022-jp?B?cTR4SEZsYmVQQlN5enZvc3U1VmgvQ0JQOFB5VFVoNERZaWRsTll5QVB0?=
 =?iso-2022-jp?B?ZzczK2VTSkMvS3hDb3BwVUsrU1d2emN4eFY1K0V6ZE81YzRNSVZVcjJ2?=
 =?iso-2022-jp?B?WTJvekFpbkd2YkpxNkFNc1ZmM2pKb1M5bWQ1L2pvcXk0VmIwWlVzUnlk?=
 =?iso-2022-jp?B?QzVCQXVlbXlDM0JEOTZ5N1hONlRCanYzUTYrcDQ4c3RDdU9jZXpwdkE4?=
 =?iso-2022-jp?B?NUJvUXNkWG5TY1JISHJsT0xYWUN1ZGZPUzBFL3p2Rk13NlNEMHE1aUlx?=
 =?iso-2022-jp?B?RWpWbHNFY09MYXlEdXNVejF5cVRNOEYrUEhuUkwvQUVTdVp1dEVkQUlE?=
 =?iso-2022-jp?B?RVo1SDNmUVRzdFFTb2QydFF4N2hDM0NIc2dDMEMwZnNxMFhtL3Z3NG41?=
 =?iso-2022-jp?B?cXVYbkczRGpkUGJzZHU2bjc5RjZkWnIzTmM2ZzlPdUNnSkdwN3l0WU90?=
 =?iso-2022-jp?B?ZGF5ZHJ0RVRaZnphalRCdDdLNTh0RnJlOW1HczF2MVNUbmErU040T3pY?=
 =?iso-2022-jp?B?eVhJZXkrZDdieXZZRTFVUlNWL2NOMFhXMW44NldrQVIwNnFNd3NOZ3Uw?=
 =?iso-2022-jp?B?RzJCQkF6TmNEOVl4ajZ3bWJLWURPL1hOWWEvVFNYcXRzTzZNakF4b2h0?=
 =?iso-2022-jp?B?cFdyUVF6cmRiL1Y2RGFFS3VadFdaMEowKy9VZzJIMCt2bndtTVpMMXdn?=
 =?iso-2022-jp?B?NEFiNWt5dDM2NmcrK3UvbXJOczVWd3Z2WUNlTkRFd25wZVpuSlRZRlNG?=
 =?iso-2022-jp?B?dFlBNzNjRERhWTdLT2djNFFtaHA5S29HbWtKUUJrM1ZtWVhIcXdYa0lV?=
 =?iso-2022-jp?B?YTN1VXF1dHc2aTB6bllNN3ZNMENpUXo2bEtiWkZIOXltRGJOWE9XaHB6?=
 =?iso-2022-jp?B?aEh5bVVjL1l2NURzbWtJb2wrNm1iWU1COHBFSFpQTkN0WFB2Mlk0L2lF?=
 =?iso-2022-jp?B?Q2VXM2ZjRGlxUTBzbml1OVo3KzdCbEkwQ3AwdXh0OG1ybDZBNXIxdGNE?=
 =?iso-2022-jp?B?NythSTlDOTlSZmlaSnY2dHpuTVIzYVp6eWZ5MjRzZjhUTk1tQlhkNFJE?=
 =?iso-2022-jp?B?cUpmYU1SZWd3d204NEFha0ZFSy9kNmNHV2w3Q2FLSWpHV091T0FQTXJH?=
 =?iso-2022-jp?B?R2xJWGgzcnMxdDZnYXB6YUFkK2xvQnB1NnlzUmo2d3NyTFdFM3BYdUJQ?=
 =?iso-2022-jp?B?eVlVcFNtWFpLdWJpVlV3YmNsNVYxNEpoWFp4QXBTTmhxamhlOUdNQllB?=
 =?iso-2022-jp?B?V0FaV1RCVEFhTURJR1hRT1FuYnNlYk52ejBtY044M1laS0hWcWVEZzZr?=
 =?iso-2022-jp?B?aUZkZEtMcjJOZjJDek95ME5GRzc0MitKRUdWTGtXNU5OZjRqZmFBWTBD?=
 =?iso-2022-jp?B?Wm8vZnNFZTk3U2ozKzFXc3owWWR6V1VyWnJ4VjhLY0xCWmVGaGpOZjc3?=
 =?iso-2022-jp?B?NStyMTI3NFZtMmVrN3NQdmRUNGtwSTZqb2VpTVZiK3dCY0U1VUh2MDVM?=
 =?iso-2022-jp?B?eGF3dlhZOUNMbkMzTkJkamRUaWlNd2ZuQUozWG8yVENLbHdabVJHWXZy?=
 =?iso-2022-jp?B?MzlhazNZa2VmOWRrVmtXTkE5K2VQcXV6SDJuWERyaUlJM2dRNUpLU05P?=
 =?iso-2022-jp?B?RUwyWHVQbHdEaVovWGQ3cUFSMVpKNmZkL3RhOVNkVFRjSWdRNGdDOGtI?=
 =?iso-2022-jp?B?RXBITjFpNWVtczFQU0lZNDFsdFVNU1p3dEdoZXhoZ0UzNXBwY2krK05R?=
 =?iso-2022-jp?B?cGVmSzg4Q2ljVnpKenlwN3U3UXB3bDYwcy9QbFlZTVNDd1YrUE84OHZY?=
 =?iso-2022-jp?B?VkJKOTZld2VCenZxWHFXS0ZwK3d0OE16VGpUdlZyNkM5MUpDTjc1VGN5?=
 =?iso-2022-jp?B?Mk1WSWk3cjZqTzI1NEw4cVFSUXBZTGJCR1NmUW9nSm0yZGM1MGM4Zy9U?=
 =?iso-2022-jp?B?cElpcWsyOE16eXF3UFZPY0cyQlBkZy9LbXc9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB61034389AED55C3BDF3D082CC2E32OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2870feaf-8d6e-489b-59da-08dc74191ae6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 13:23:55.3992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q7UybqY2VKp3Dw2b5Q7tUgcI7O7QqAhk4tukf2ZCe9Rt3XZV9+4tBdTzbO5s0eXi0XGE+wJ/QrQoXW3RxetjdHbzb9i1BFYMLO/uxp68igI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6095
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 May 2024 13:24:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15892

--_000_OS3PR01MB61034389AED55C3BDF3D082CC2E32OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

Thank you so much for creating group, projects and a user in CIP SQUAD.

Regards,
Sai Ashrith Sathujoda (T S I P)

From: Chris Paterson <Chris.Paterson2@renesas.com>
Sent: Tuesday, May 14, 2024 6:49 PM
To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>
Cc: cip-dev@lists.cip-project.org; dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC OD=
G Porting) <dinesh.kumar@toshiba-tsip.com>
Subject: RE: Query regarding SQUAD watch job submission

Hello Sai,

I=1B$B!G=1B(Bve created a new group and the projects you=1B$B!G=1B(Bve aske=
d for: https://squad.ciplatform.org/cip-core/
I=1B$B!G=1B(Bve also created a user for you. I=1B$B!G=1B(Bll email the deta=
ils separately.
You=1B$B!G=1B(Bll be able to log in and view your token here: https://squad=
.ciplatform.org/_/settings/api-token/

Kind regards, Chris

From: Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>=
 <Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>>
Sent: Thursday, May 9, 2024 6:25 PM
To: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@rene=
sas.com>>
Cc: Sietze.vanBuuren@de.bosch.com<mailto:Sietze.vanBuuren@de.bosch.com>; ci=
p-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>; dinesh.k=
umar@toshiba-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>
Subject: RE: Query regarding SQUAD watch job submission

Hello Chris,

Hope you are doing well.

The issue I mentioned in the previous mail in this thread is resolved now s=
o please ignore that query if you have not gone through yet.

As mentioned earlier we are planning to add CIP-Core LAVA test results in C=
IP SQUAD. It will be of great help to us if you provide your support in thi=
s.

Can you please create a group named =1B$B!H=1B(Blinux-cip-core=1B$B!I=1B(B,=
 three projects named =1B$B!H=1B(BSwupdate-testing=1B$B!I=1B(B, =1B$B!H=1B(=
BSecure boot testing=1B$B!I=1B(B and =1B$B!H=1B(BIEC Layer testing=1B$B!I=
=1B(B under that group ?

Currently I believe that results present under various projects in =1B$B!H=
=1B(Blinux-cip=1B$B!I=1B(B and =1B$B!H=1B(Blinux-stable-rc=1B$B!I=1B(B will=
 not be disturbed while we experiment in adding CIP Core LAVA results in th=
e projects under =1B$B!H=1B(Blinux-cip-core=1B$B!I=1B(B group. Please corre=
ct me if I am wrong about this.

We also need a user created in CIP SQUAD with a SQUAD token assigned to, so=
 that we can start modifying this script lava.sh * master * cip-playground =
/ cip-core-ci * GitLab<https://gitlab.com/cip-playground/cip-core-ci/-/blob=
/master/lava.sh?ref_type=3Dheads> to experiment on hosting CIP Core LAVA re=
sults on SQUAD.

Chris, I request you to add the mentioned items to CIP SQUAD which will hel=
p us to start this task as soon as possible.

If there are any issues with doing these changes to current CIP SQUAD, plea=
se let me know.

Note: If anyone has any concerns about the group and project names proposed=
 above, please reply to this email.

Thanks and regards,
Sai Ashrith Sathujoda (T S I P)



From: ashrith sai(=1B$B#T#S#I#P=1B(B)
Sent: Friday, May 3, 2024 12:53 AM
To: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@rene=
sas.com>>
Cc: Sietze.vanBuuren@de.bosch.com<mailto:Sietze.vanBuuren@de.bosch.com>; ci=
p-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>
Subject: Query regarding SQUAD watch job submission

Hi Chris,

Hope you are doing well.

We are planning to post CIP Core LAVA testing results on CIP SQUAD instance=
. So I am trying to setup a local SQUAD instance and integrate it with my l=
ocal LAVA Lab so that I can understand the traceability between changes req=
uired in https://gitlab.com/cip-playground/cip-core-ci/-/blob/master/lava.s=
h?ref_type=3Dheads and results displayed on the dashboard.

I followed the below mentioned steps:


  1.  I started the server locally after following the steps mentioned in t=
his README file squad/doc/quickstart.rst at master * Linaro/squad * GitHub<=
https://github.com/Linaro/squad/blob/master/doc/quickstart.rst> .
  2.  After the server started, I was able to access web UI at localhost:80=
00.
  3.  I followed the steps mentioned in https://github.com/Linaro/squad/blo=
b/master/doc/lava_usecase.rst#creating-a-backend-for-a-lava-instance to  cr=
eate backend for my LAVA instance.
  4.  I created a fresh token in API -> Authentication token in my local LA=
VA Lab and I added that token while creating the SQUAD backend.
  5.  I created a SQUAD token based on my SQUAD username and I referenced t=
hat token as value to Authorization token: while using SQUAD watch job API.
  6.  I added my LAVA username in the username section while creating the b=
ackend.
  7.  I created a sample group in the administration page, and I selected t=
hat group slug while creating a project in administration page.

After I gathered all these details, I modified submit_jobs script to test w=
hether I can attach a SQUAD watch job to a just-submitted LAVA job based on=
 it=1B$B!G=1B(Bs job ID.

After I submit my job to LAVA, I am immediately calling the watch job API t=
o attach a watch job to the submitted LAVA job. But I am getting the below =
mentioned error message.

$ ./local_lava.sh
/tmp/tmp.FJGGBcxzNn/IEC_amd64.yml is a valid definition
There are currently 1 "qemu" devices online.
Submitting /tmp/tmp.FJGGBcxzNn/IEC_amd64.yml to LAVA master...
Job submitted successfully as #634.
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Cur=
rent
                                 Dload  Upload   Total   Spent    Left  Spe=
ed
100   315  100    56  100   259   9333  43166 --:--:-- --:--:-- --:--:-- 52=
500
Something went wrong with SQUAD watch job submission. SQUAD returned:
{"detail": "User needs permission to submit test jobs."}
SQUAD URL: http://127.0.0.1:8000/api/submitjob/tsip_squad/cip-core-testing/=
2.0/local_env
SQUAD Backend: lavabackend.org
LAVA Job Id: 634

I am attaching my script to this email which can make it easier for you to =
point my mistakes. No issues regarding the exposed token I am using in the =
script since this is a local setup done for my understanding. Please have a=
 look at lines 17-22 and 107-137 which contain changes made to call SQUAD w=
atch job API.

I will also attach screenshots for group, project and backend page in my SQ=
UAD admin section which might be helpful to point out if I passed wrong dat=
a to SQUAD watch job API call.

Please have a look at this data and kindly provide your suggestions which c=
an help me fix this problem.

Thanks and regards,
Sai Ashrith Sathujoda (T S I P)







--_000_OS3PR01MB61034389AED55C3BDF3D082CC2E32OS3PR01MB6103jpnp_
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
	{mso-list-id:1719669283;
	mso-list-template-ids:-526081502;}
@list l1
	{mso-list-id:1814715072;
	mso-list-type:hybrid;
	mso-list-template-ids:-1592213718 67698703 67698713 67698715 67698703 6769=
8713 67698715 67698703 67698713 67698715;}
@list l1:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
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
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Hi Chris,=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Thank you=
 so much for creating group, projects and a user in CIP SQUAD.<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Regards,<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Sai Ashri=
th Sathujoda (T S I P)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Calibri&quot;,sa=
ns-serif;mso-ligatures:none;mso-fareast-language:KO">From:</span></b><span =
style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-=
fareast-language:KO"> Chris Paterson &lt;Chris.Paterson2@renesas.com&gt;
<br>
<b>Sent:</b> Tuesday, May 14, 2024 6:49 PM<br>
<b>To:</b> ashrith sai(</span><span lang=3D"KO" style=3D"font-family:&quot;=
Gulim&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:KO">=1B$B#T#=
S#I#P=1B(B</span><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;=
mso-ligatures:none;mso-fareast-language:KO">) &lt;Sai.Sathujoda@toshiba-tsi=
p.com&gt;<br>
<b>Cc:</b> cip-dev@lists.cip-project.org; dinesh kumar(</span><span lang=3D=
"KO" style=3D"font-family:&quot;Gulim&quot;,sans-serif;mso-ligatures:none;m=
so-fareast-language:KO">=1B$B#T#S#I#P=1B(B</span><span style=3D"font-family=
:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:KO"=
>
 TMIEC ODG Porting) &lt;dinesh.kumar@toshiba-tsip.com&gt;<br>
<b>Subject:</b> RE: Query regarding SQUAD watch job submission<o:p></o:p></=
span></p>
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
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">I=1B$B!G=1B(=
Bve created a new group and the projects you=1B$B!G=1B(Bve asked for:
<a href=3D"https://squad.ciplatform.org/cip-core/">https://squad.ciplatform=
.org/cip-core/</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">I=1B$B!G=1B(=
Bve also created a user for you. I=1B$B!G=1B(Bll email the details separate=
ly.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">You=1B$B!G=
=1B(Bll be able to log in and view your token here:
<a href=3D"https://squad.ciplatform.org/_/settings/api-token/">https://squa=
d.ciplatform.org/_/settings/api-token/</a><o:p></o:p></span></p>
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
<b>Sent:</b> Thursday, May 9, 2024 6:25 PM<br>
<b>To:</b> Chris Paterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com=
">Chris.Paterson2@renesas.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:Sietze.vanBuuren@de.bosch.com">Sietze.vanBuure=
n@de.bosch.com</a>;
<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.cip-project.=
org</a>;
<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar@toshiba-tsip.=
com</a><br>
<b>Subject:</b> RE: Query regarding SQUAD watch job submission<o:p></o:p></=
span></p>
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
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">The issue=
 I mentioned in the previous mail in this thread is resolved now so please =
ignore that query if you have not gone through yet.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">As mentio=
ned earlier we are planning to add CIP-Core LAVA test results in CIP SQUAD.=
 It will be of great help to us if you provide your support in this.<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Can you p=
lease create a group named =1B$B!H=1B(Blinux-cip-core=1B$B!I=1B(B, three pr=
ojects named =1B$B!H=1B(BSwupdate-testing=1B$B!I=1B(B, =1B$B!H=1B(BSecure b=
oot testing=1B$B!I=1B(B and =1B$B!H=1B(BIEC Layer testing=1B$B!I=1B(B under=
 that group ?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Currently=
 I believe that results present under various projects in =1B$B!H=1B(Blinux=
-cip=1B$B!I=1B(B and =1B$B!H=1B(Blinux-stable-rc=1B$B!I=1B(B will not be di=
sturbed while we experiment in adding CIP Core LAVA results in the projects=
 under
 =1B$B!H=1B(Blinux-cip-core=1B$B!I=1B(B group. Please correct me if I am wr=
ong about this.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">We also n=
eed a user created in CIP SQUAD with a SQUAD token assigned to, so that we =
can start modifying this script
</span><a href=3D"https://gitlab.com/cip-playground/cip-core-ci/-/blob/mast=
er/lava.sh?ref_type=3Dheads">lava.sh &middot; master &middot; cip-playgroun=
d / cip-core-ci &middot; GitLab</a> to experiment on hosting CIP Core LAVA =
results on SQUAD.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Chris, I request you to add the mentioned items to C=
IP SQUAD which will help us to start this task as soon as possible.<o:p></o=
:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">If there are any issues with doing these changes to =
current CIP SQUAD, please let me know.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><b>Note: If anyone has any concerns about the group =
and project names proposed above, please reply to this email.<o:p></o:p></b=
></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks and regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Sai Ashrith Sathujoda (T S I P) <span style=3D"mso-f=
areast-language:EN-US">
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
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
<b>Sent:</b> Friday, May 3, 2024 12:53 AM<br>
<b>To:</b> Chris Paterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com=
">Chris.Paterson2@renesas.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:Sietze.vanBuuren@de.bosch.com">Sietze.vanBuure=
n@de.bosch.com</a>;
<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.cip-project.=
org</a><br>
<b>Subject:</b> Query regarding SQUAD watch job submission<o:p></o:p></span=
></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hi Chris,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hope you are doing well.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">We are planning to post CIP Core LAVA testing result=
s on CIP SQUAD instance. So I am trying to setup a local SQUAD instance and=
 integrate it with my local LAVA Lab so that I can understand the traceabil=
ity between changes required in
<a href=3D"https://gitlab.com/cip-playground/cip-core-ci/-/blob/master/lava=
.sh?ref_type=3Dheads">
https://gitlab.com/cip-playground/cip-core-ci/-/blob/master/lava.sh?ref_typ=
e=3Dheads</a> and results displayed on the dashboard.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I followed the below mentioned steps:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<ol style=3D"margin-top:0in" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l1 level1 =
lfo3">I started the server locally after following the steps mentioned in t=
his README file
<a href=3D"https://github.com/Linaro/squad/blob/master/doc/quickstart.rst">=
squad/doc/quickstart.rst at master &middot; Linaro/squad &middot; GitHub</a=
> .<o:p></o:p></li><li class=3D"MsoListParagraph" style=3D"margin-left:0in;=
mso-list:l1 level1 lfo3">After the server started, I was able to access web=
 UI at localhost:8000.<o:p></o:p></li><li class=3D"MsoListParagraph" style=
=3D"margin-left:0in;mso-list:l1 level1 lfo3">I followed the steps mentioned=
 in
<a href=3D"https://github.com/Linaro/squad/blob/master/doc/lava_usecase.rst=
#creating-a-backend-for-a-lava-instance">
https://github.com/Linaro/squad/blob/master/doc/lava_usecase.rst#creating-a=
-backend-for-a-lava-instance</a> to&nbsp; create backend for my LAVA instan=
ce.<o:p></o:p></li><li class=3D"MsoListParagraph" style=3D"margin-left:0in;=
mso-list:l1 level1 lfo3">I created a fresh token in API -&gt; Authenticatio=
n token in my local LAVA Lab and I added that token while creating the SQUA=
D backend.<o:p></o:p></li><li class=3D"MsoListParagraph" style=3D"margin-le=
ft:0in;mso-list:l1 level1 lfo3">I created a SQUAD token based on my SQUAD u=
sername and I referenced that token as value to
<b>Authorization token: </b>while using SQUAD watch job API.<o:p></o:p></li=
><li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l1 level1=
 lfo3">I added my LAVA username in the username section while creating the =
backend.<o:p></o:p></li><li class=3D"MsoListParagraph" style=3D"margin-left=
:0in;mso-list:l1 level1 lfo3">I created a sample group in the administratio=
n page, and I selected that group slug while creating a project in administ=
ration page.<o:p></o:p></li></ol>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">After I gathered all these details, I modified submi=
t_jobs script to test whether I can attach a SQUAD watch job to a just-subm=
itted LAVA job based on it=1B$B!G=1B(Bs job ID.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">After I submit my job to LAVA, I am immediately call=
ing the watch job API to attach a watch job to the submitted LAVA job. But =
I am getting the below mentioned error message.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">$ ./local_lava.sh<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">/tmp/tmp.FJGGBcxzNn/IEC_amd64.yml is a valid definition<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">There are currently 1 &quot;qemu&quot; devices online.<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">Submitting /tmp/tmp.FJGGBcxzNn/IEC_amd64.yml to LAVA maste=
r...<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">Job submitted successfully as #634.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">&nbsp; % Total&nbsp;&nbsp;&nbsp; % Received % Xferd&nbsp; =
Average Speed&nbsp;&nbsp; Time&nbsp;&nbsp;&nbsp; Time&nbsp;&nbsp;&nbsp;&nbs=
p; Time&nbsp; Current<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Dload&nbsp; Upl=
oad&nbsp;&nbsp; Total&nbsp;&nbsp; Spent&nbsp;&nbsp;&nbsp; Left&nbsp; Speed<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">100&nbsp;&nbsp; 315&nbsp; 100&nbsp;&nbsp;&nbsp; 56&nbsp; 1=
00&nbsp;&nbsp; 259&nbsp;&nbsp; 9333&nbsp; 43166 --:--:-- --:--:-- --:--:-- =
52500<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">Something went wrong with SQUAD watch job submission. SQUA=
D returned:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">{&quot;detail&quot;: &quot;User needs permission to submit=
 test jobs.&quot;}<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">SQUAD URL:
<a href=3D"http://127.0.0.1:8000/api/submitjob/tsip_squad/cip-core-testing/=
2.0/local_env">
http://127.0.0.1:8000/api/submitjob/tsip_squad/cip-core-testing/2.0/local_e=
nv</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">SQUAD Backend: lavabackend.org<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">LAVA Job Id: 634</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am attaching my script to this email which can mak=
e it easier for you to point my mistakes. No issues regarding the exposed t=
oken I am using in the script since this is a local setup done for my under=
standing. Please have a look at lines
<b>17-22 </b>and <b>107-137 </b>which contain changes made to call SQUAD wa=
tch job API.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I will also attach screenshots for group, project an=
d backend page in my SQUAD admin section which might be helpful to point ou=
t if I passed wrong data to SQUAD watch job API call.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Please have a look at this data and kindly provide y=
our suggestions which can help me fix this problem.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks and regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Sai Ashrith Sathujoda (T S I P)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
</body>
</html>

--_000_OS3PR01MB61034389AED55C3BDF3D082CC2E32OS3PR01MB6103jpnp_--


