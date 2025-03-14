Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C5BC28B2F
	for <webhook@archiver.kernel.org>; Fri, 14 Mar 2025 06:27:33 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.7645.1741933647328718427
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Mar 2025 23:27:28 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 52E6RPKJ1942705; Fri, 14 Mar 2025 15:27:25 +0900
X-Iguazu-Qid: 2yAbaKzOgiBpx4ntZP
X-Iguazu-QSIG: v=2; s=0; t=1741933645; q=2yAbaKzOgiBpx4ntZP; m=xex7JaS01GVvlDCVEwH4evjPfh1DWnVm67QbjtQN/R8=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 52E6RONl256708
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 15:27:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MvfQUjTDZpuxO/1+UZ/2wm6FspnMSk0CmUNAuV1o5sqUJIyc6F9wlUYbDL4WRaVLZu3X30fof8HFsu9tW/EcG0HQ0wxTd9jFiLszNutxFG62W16pYiD7pbygVV1mjuTyHFMoBAJkGC8d4//xoroATdj/kxnIeJ9K4ec9JfyK4b6eCf8QPbKPNLWAVN6HlwOfLTh3Dc4qvcDVGExpDiOkyBIc0A5ZUzeg1awvr8NYkXZWFBV1tfSJLUSnm4f9ZsINgtkZe2KJVr5zUaSdg+R5NApeEOsT0NINZiphiAGy0VootFtZhtB9z6KovjmFZieEVKkwrdTZYFjSSfwZws784Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuyapF4bgyC99zobyKBYVlFY+0D8FCHoB6Os15fmkGY=;
 b=ZErdBIMsg/EJ2q0xq0XMRa0mmLRfyjJpTgI2r0EdyiUltRmsg0+92jtroeXw2P6jBXZ3teSMHC116nknyaqi5fMzXjRl2yTGqUd4Z/KeRUtz0g8FCUXECY8Hp8Snx7j5AvzMgvDYTDp397nfX+/aSDlzhRmGMs0puPrTftGeEqLIF4FiMzC+tsELKpnKJGfeRRKT/vOJmF/joU1e1MIaq8F/vc9Akp7wtFRp1BEsISfq/sPLHCIJth4qjAbBEs+xb/9LIDigbyqKOadsos2R6mlCUSl7YDuKjgoNH++fukqpaqY+3sGJSKqc83GysuxSk21Azdy0GlTVxgmd96wOvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <Shivanand.Kunijadar@toshiba-tsip.com>, <Sai.Sathujoda@toshiba-tsip.com>,
        <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: Re: [isar-cip-core][PATCH v1] .reproducible-check-ci.yml: Add
 x86-uefi target for reproducibility test
Thread-Topic: [isar-cip-core][PATCH v1] .reproducible-check-ci.yml: Add
 x86-uefi target for reproducibility test
Thread-Index: AQHblKdFrO/B00cQCE+rogHKxQO4r7NyKZuAgAAAYYw=
Date: Fri, 14 Mar 2025 06:27:22 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB96693C5689579DB44DB76D16C4D22@TYCPR01MB9669.jpnprd01.prod.outlook.com>
References: <20250314061421.2146773-1-Adithya.Balakumar@toshiba-tsip.com>
 <e257c556-a123-4b71-a8f7-725581dda22e@siemens.com>
In-Reply-To: <e257c556-a123-4b71-a8f7-725581dda22e@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|OSRPR01MB11520:EE_
x-ms-office365-filtering-correlation-id: 34b2d58b-0261-401e-c15f-08dd62c147b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?TUl6NGszY0lGcmFFRk5aYzM1M3BXTjEvTlNQL3lzRkRLWFJMODYvN21h?=
 =?iso-2022-jp?B?Vm5XZ25ZKzB3L0c2L1RINkdJVis1a1BSN0ZzQ0VpZHdLNmRIdVVKd1hh?=
 =?iso-2022-jp?B?RUVvSzZsS3MzTmZmdDZqUW9GR2Q2dTNmUmlhUkluSzRZN0p6cXByYzJR?=
 =?iso-2022-jp?B?RW9XdEwvMGVNekszenBycDM3d2dMd1o1NkZGNGtJb3FRUDUzZmVqL3B4?=
 =?iso-2022-jp?B?d0hvVkczZC8yRHArV255ZCtLOXNoNmxBRXI3Sy9ZS3JJVno1ckR2U0J4?=
 =?iso-2022-jp?B?WnIzdHVBODl6cDBFeWIvYU5DS2x2eTNZTW9lOFVNQ2NuWVVTdlNIYzkr?=
 =?iso-2022-jp?B?RjdXUG1HN1pyWWQwcVZrZ2RrY3VRcW1wOUZCeHJOZlQ5bng4S3d5ai9i?=
 =?iso-2022-jp?B?WUZGMlE1TkxRZlkzNWx1eUpLcW5QNkFQd3dRZ0JrdnNDZzdXNk8vY2VR?=
 =?iso-2022-jp?B?MzFZRE5EYk0vemFHMFF2RVBvYXN2V3JkbDFJUlNLVTFYK2tFcjloZ3g2?=
 =?iso-2022-jp?B?Q0taZXFLcHZzdVdGb3RKdzBmckhLWTlhellpeS84NmZOc2k5WmlseDF4?=
 =?iso-2022-jp?B?dWovUS9vRVpKNTVLeHlyc2pCL3Nnd0NmN3dUMzNKbHlVdHovcWJuc1l6?=
 =?iso-2022-jp?B?VHJrYUMwMzBuZFY3b29KazVzaXBmdC9ua29tNTFlbGNXVHZ6L1FDQzRM?=
 =?iso-2022-jp?B?VkZ5ZXBmY3c5RUZlcVB3MFdScTRnSDcwMVVFcjdFc0V3VVhQYW1SUzB4?=
 =?iso-2022-jp?B?UUxZQTROb0NxcitvZU4wSXlyelgrT05obHd0c2NkREZhbWR4YjROdTJl?=
 =?iso-2022-jp?B?QjAwMURsU0o4M253ZmdkS1VQWXhjL3ZTV1RRdGNuc2p1aTlHM3U5K3Aw?=
 =?iso-2022-jp?B?SzZRYjN5NGlNSXhJMzdxaFowdXBsOWtaWWFvUUF3c1FtQ2kvcEFBbWhM?=
 =?iso-2022-jp?B?Qnd0K0RoTFRuRk9wV29hYUUvNnRrejhqQ1NadjBPdXkrR3Y1MjdoaHE3?=
 =?iso-2022-jp?B?OFFMcjduQ3BvU2pYdmdHS2lpZzk2ZnV6ODZucDJuVzd1enJ6b2NlUldP?=
 =?iso-2022-jp?B?bnAxdjhvRG1zNVVRenFtOHFUNkJSZ0JjUHBQR2lvSVRhcmNIa3lhRHN6?=
 =?iso-2022-jp?B?dElVTkR3VHhQTUZIRGZEcnRCWnFqRFhLZW8zTjBEVmtkM2RHNkp4Y05V?=
 =?iso-2022-jp?B?QVB4Z0MyY3lLcEV1VkdDVWg0WTMrbUZub29jWDFGc2dpL1Q3WmVjT3pG?=
 =?iso-2022-jp?B?Vjl0d0VqSUpvNVl3a3RTUkVJUWlQSWhXNU5IYXZLOUFBZ1YwQUNsaTEz?=
 =?iso-2022-jp?B?c3FTZk1VeHpwcUpGTzZjbGR5WGwxTUMxK2JjMjhwQ2lQbDlZRnVXdCtp?=
 =?iso-2022-jp?B?dTROZ1ZmckRXVlRydjl5Z3doUkRDK2xnS1dSOVVpUyttdHNiM0FVdElG?=
 =?iso-2022-jp?B?QkhxWkhORW9uQXJUMHhFMGZibENZaHdURlJSaEtBMU40NUxMK0V3OW1q?=
 =?iso-2022-jp?B?RlZYODlkQ3EvbmdTdXlNMENPcEZJaXlkbE5sRDQ5eEt2V0JPMm9LcnB4?=
 =?iso-2022-jp?B?YjZrR1BTcVJoM1BXa2RFalk3Wk54aW5PYkU0eENzNHJ5MS9lZWlKVENx?=
 =?iso-2022-jp?B?YStqTndrREJ0UFhKMlRFR2xWUEdORW1QSFFmTUpnYlFaaFF2QjNBMTBD?=
 =?iso-2022-jp?B?SFBBQVNLazF6VnZDa3dVWnMwb3JOTXNrTXRDVVptSEdKM0NGWDVMZWxD?=
 =?iso-2022-jp?B?TmZCa3ZQdlBSdkFvcWNIR2JmelNpYUtraGZkZ3YxeTVDa25LTHRkYUdH?=
 =?iso-2022-jp?B?OXcrRS9TdXMxSDMyczg2Z2dXMGorTzV4ZW5MdS9za0ZZUnVncm4xK1Vh?=
 =?iso-2022-jp?B?OTkxcWNxSG1RRHZEb0ZoWFR1Nkw1a0lwL2plRG9uemVpc1l4WFZaRWdE?=
 =?iso-2022-jp?B?VTROR0kvZU5KSTQ3amQ4VW1wamhqeU5HZFpyNWFyNlQvMm9OdllCbnBh?=
 =?iso-2022-jp?B?aXVzdW0zOFo5NlovVjRCbE5wT0VENg==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?S00yVlhkN29EMFZ1VzlvZ0FKUHJpcXp1d2dKWkNDRXBOZkxrM2M3Yjcx?=
 =?iso-2022-jp?B?ZHhyaTZ1M0J2ZzJESDFGUmtlSzJNQTBXZzFBSldha3RCUENmbnNmTjBp?=
 =?iso-2022-jp?B?KzhQMGlzR3lieHZNaXNnWEZsT3B5L0x4VmRhTU5FU2JIdXdVUGNkTHJM?=
 =?iso-2022-jp?B?M25yQXZkb2J3MHdycVF0WE9ldUZSbjFZRE1xZ0tpcU1aWjIvaEVXUWxQ?=
 =?iso-2022-jp?B?aGdSU1VNeE90TEh0UStCdU9lSTJEV1poMW5tOXZhbFVUSUN6ZWhzR3Iv?=
 =?iso-2022-jp?B?VXpHTldiZE5hbTEwZWVaWkE4VzZSMTBqaEpSZkErVmxKR1MwQWEzc1Rm?=
 =?iso-2022-jp?B?WXNzUUJkV2tnQXdyY0dMWXJGc2FrdjhodlFmblJJM0tvSldaTU1rSkxT?=
 =?iso-2022-jp?B?R1p3OEI4aC8xRklCUXBxbEFTQndnUjlDUDNmeHBoT1lEWExBRWt2NVo4?=
 =?iso-2022-jp?B?SGJOamlRL0xmRFBRSEQvL3Q1SDUyY1BUbEh2T250d1pYSlhlVmp4RUJI?=
 =?iso-2022-jp?B?SVJiK0k1OHJESkQ4SVptWHhadlF4eEZ3cm9hdDB1YzZ4RmNJYlVqbTg3?=
 =?iso-2022-jp?B?U2xaN1pMUUprczJLZzN4S0wyZnZpVmxMeFZENXkwM0ViN0lXWlE0ekh6?=
 =?iso-2022-jp?B?ak8rUytHWU5ERlBiaGR2WHkzaWhnNHNEelQ5YWRUMG0vZkVBQitRK3FJ?=
 =?iso-2022-jp?B?ajhrbXEydWlmZUU5TjBQekZvTC9UNzlIZisrVzJvVkFFNlhHVVg1enp2?=
 =?iso-2022-jp?B?cCt2N2NFdXpjZklmUHF5dHFBT0NTZ1BjWU1sUXVsZ3NtVC92azlOaVRy?=
 =?iso-2022-jp?B?WjZ2bkljeUF0bmc1ZktNYWkyTStIbDZ4SE5sNW5hVmpmL2NzUk1aYmlL?=
 =?iso-2022-jp?B?ZmptSXRCOGVCWkVZMEcxbzVjc0FEeGo3bDIyU3Z6ZHVyTEFUTSs3ckF6?=
 =?iso-2022-jp?B?elFQaVBQZm9ZN1kzNHdGYTNDODZ0M2l6c0x6WkFtQ05pR05KTHQ1eEN0?=
 =?iso-2022-jp?B?ZzQ0ZnIvQjdDYysxN3pxSkx4OFBpT2RIdkYwWmo2SmkyU1VxTm8rV1NI?=
 =?iso-2022-jp?B?VEh4YUU0UGVGNFlteW5mOXhFZGJ3bk9xR01nUHN3L1dZUk5Jc0lDTzFi?=
 =?iso-2022-jp?B?c29hSFVnQ2UrM1g1SFZMVEpFK2thTjhUd0RKK2kwZ2FiREV5bFJBSmZ5?=
 =?iso-2022-jp?B?T3Rmamd0VXFIbFFIZGlaQ3A3dWhSWnE4anoyLzJtSVI5dTY3UmhrQWZ3?=
 =?iso-2022-jp?B?eHc3YXNIcDFRd1pZbnUvR1JtQUhxSzh1eTFucG4rbFBLVjl6M2svM3Zm?=
 =?iso-2022-jp?B?N1BhTVM0UmdoL2JwNmt6TGc4b0xrT2J1RU9QTmRVVlFrM0czdFdMS0h5?=
 =?iso-2022-jp?B?MTJxR2w3ZFcwL21XUUhjWUtLcysxTDdqTlN3MkRRTE15R3I3RDJqdm1p?=
 =?iso-2022-jp?B?d3BwSjBjMnVObjRtc2JFa2lDWmlLa3A3emJzY050VVFsc2RUNnFMTmJ1?=
 =?iso-2022-jp?B?WGNIUDFEYWJueC9sNk9jZGVDelljNXI2UW1qQUgwVTRreGVBMjEvazZz?=
 =?iso-2022-jp?B?Z1JaMldwQWhFdENTNWtRTXFjaWgwQXVFVHJYdnJ3YXpqcVl1K2Yrd2xM?=
 =?iso-2022-jp?B?RW9YaHRYSTRjNTJ1THYyZTdjTDFzUmI5SDFsMWZJL2lhSlIyVTNzT2FS?=
 =?iso-2022-jp?B?L0VWWHpJeC9STlJ2OXdiRUM2Tkt2K0w4Y0ZSb2xIZlhvOFM1bzNrbWdU?=
 =?iso-2022-jp?B?OGFQcU96MnUySTNKbDl5c2FubGVtWWtNZ2FOb25vclRMM3VyYXZpTjV2?=
 =?iso-2022-jp?B?T05sR0MyZVFXNVdPWTl6TjQwRWFWU21zR3B3a1FCUHpjMElNTlFmb2or?=
 =?iso-2022-jp?B?QTh4QWZNNlFPUEtocGkzdTlJZ2svTnZxTTgxanMrMlRkWDdHV0puc2dy?=
 =?iso-2022-jp?B?d1ZLR096ejFmL0pnZ09WMTh5TldpUVNOYUQ3SXI3b3dKa2kxbE85VnI4?=
 =?iso-2022-jp?B?eHd5ZXNtSkljdXVUK2R0U2dPMmZqZGVGSzdWcHFlY3hUcDR4VVQ1UExL?=
 =?iso-2022-jp?B?OU1pamg2N3lBanpwZG5yRC95QnY1K1g1ZXBYNGh4UUxFMFdjakdTZkxv?=
 =?iso-2022-jp?B?RUxvSnB5cFh1Wk1UVmZ5WEd0UUxKS0NMWGFqaGs0K2RTS0E2QUpBbHhX?=
 =?iso-2022-jp?B?ZUxIWTlWOXp6bllqYWdJckxVdlQ1cXM5T1JtNFlzUnBhN1dWQjYvVjRj?=
 =?iso-2022-jp?B?T05iUnJKT3ZTbEdhQzJjd3BDMDNPR0I1UjNpcmxjZ0FGU0lVbnVwVldT?=
 =?iso-2022-jp?B?NXE4QTJ4Y1pudnhNZ3owZXJnT0QxQ3hPeEE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b2d58b-0261-401e-c15f-08dd62c147b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 06:27:22.7843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LqKMF6yf4O+gYGrYn/IoZVxvIZcggF/y+socYeXanYtPnJVqBDWVqiCBhfy1qTKGtLfmD5Tg56B4NXOMh1bpRjFXSYQe9zvosgFtGBAco+rqbQnlg9ueG/39MdBUXubn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11520
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Mar 2025 06:27:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18202

Hi Jan,=0A=
=0A=
>Thanks, applied (assuming that this passes right now).=0A=
=0A=
Yes, the CI passes. Ran the CI reproducibility test[1] with the patch share=
d.=0A=
[1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/17162=
07403=0A=
=0A=
Thanks and Regards,=0A=
Adithya Balakumar =0A=


