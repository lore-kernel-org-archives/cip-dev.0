Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7866D116E2
	for <webhook@archiver.kernel.org>; Mon,  1 Dec 2025 06:34:17 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15451.1764570850649154288
 for <cip-dev@lists.cip-project.org>;
 Sun, 30 Nov 2025 22:34:11 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 5B16Y7VU3202517; Mon, 1 Dec 2025 15:34:08 +0900
X-Iguazu-Qid: 2rWgRWki9Kl3Xrp9jZ
X-Iguazu-QSIG: v=2; s=0; t=1764570847; q=2rWgRWki9Kl3Xrp9jZ; m=z+0LLapCMh5jdPMQ1RCJvbl1+2uXQpty9I8l2iMBpS8=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dKYyl12JLz1xnf; Mon,  1 Dec 2025 15:34:06 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7valRUNOJ6yhYCxtfWH1na2FdhbPTUqUjm1njFllUOTJavcHlIg/VMltRqjhcNePClm4KB487xot87kWN6fH5eYPKtSOhVIwaAuJTjsyu8K7Q5o6U/TjIe4+d3evLXqg5AbKfDN8fz95EX2988iAtXM6ZrQFNNXWk7v+tTYgge3Poh8spLAOtUBrJSXZmv0TzFpv3m7PBQcXM7vHPkma1H8KtDhK4R2aODm5xTNtHXyTSBsE048GHiPZuFoLoHHVSA8q+rvCZlmnv8zJPOvA2lJtYHW7+eBX04RPf5pPniH4IPDqACVPCmCtxzRz9KEZ1qeQ1OGv3NktFJN+FtR/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g31A4CUt3uTT5gxJT8Hvh7s8UiJRXyCPm47g/VVuYVs=;
 b=AfACZCFNjESgYB5Px6B6gyK3o7oLByc3e0WXtkkfG2ZuY1jkVYHupYZMCjMmIjNv3E0nxwtoflJlw1djgEgq/Jl3/ahrlR+oPCuKJ8gTqGfGi45p9C+cixEK095a6S03dRtuTCDB/kWTQN5Q5EryUYM+C73tl8muGR88FZgodAXYoKWJDmy32w2/Yr1Za3AY2PFDtTk9R5onDhnr7T7zisEYyb7pfMfOeWaqja90GZm4Isd2CgZZwV+KmOkQ64sfeB5CbjC7t3r9d7QBFqwNNG9uswJBJ04MQvVTB0pj7F20WCWLisPMVKsjfw7XQJ7hdrOj3iIkCm2znh2l7CJUew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <gourav.singh.ext@siemens.com>, <jan.kiszka@siemens.com>,
        <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro.hayashi.f74@mail.toshiba>
Subject: RE: [isar-cip-core][PATCH] fix(security): add libpam-systemd in
 Debian trixie
Thread-Topic: [isar-cip-core][PATCH] fix(security): add libpam-systemd in
 Debian trixie
Thread-Index: AQHcXfvpaLlYrsWecEGOFUyITH/p07UH1RRggACRkQCAA/OOwA==
Date: Mon, 1 Dec 2025 06:34:03 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB11075487F807948669EB3B386C7DBA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
References: <20251124050607.876836-1-gourav.singh.ext@siemens.com>
 <345f8c1e-0166-4946-893b-02dba9dd71ce@siemens.com>
 <KL1PR0601MB4697CEAF6AACC78EAB99E5CBD5D0A@KL1PR0601MB4697.apcprd06.prod.outlook.com>
 <e3ea7e4e-7679-4ddb-9074-fab4f51c8c8a@siemens.com>
 <KL1PR0601MB4697F954236371E6E07F0C35D5D1A@KL1PR0601MB4697.apcprd06.prod.outlook.com>
 <TY3PR01MB11075803A132ED49E1CFE0D57C7DCA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <KL1PR0601MB46979F20EA9D028D3ABF2C57D5DCA@KL1PR0601MB4697.apcprd06.prod.outlook.com>
In-Reply-To: 
 <KL1PR0601MB46979F20EA9D028D3ABF2C57D5DCA@KL1PR0601MB4697.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=0001db07-203a-4ae8-ba26-24b6838cdfd4;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-11-25T10:58:43Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|TYRPR01MB12758:EE_
x-ms-office365-filtering-correlation-id: a613b8fc-1861-4873-c9f1-08de30a39f1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?YXNqTU9VU0x1bEpXNjE3TitSK2ltakNkRld5VG1lNHNQS3c1T2g5aEZX?=
 =?iso-2022-jp?B?YyswaTBKSjBWUCtIY2xHTUhKbGh4M3V1UEZWbmlCS2IzQzBpTU9NVWt5?=
 =?iso-2022-jp?B?OFNPUCtIUjlLQnRmSUtVeVo4dzE2bGYxNE1TSlJNUWZ3MDRRdjc4cEFx?=
 =?iso-2022-jp?B?RklHYk1TazJJcUYyNXUyYW5qZnhRUVYyaDdBR0NaTEh6VzIrMGhwTW9j?=
 =?iso-2022-jp?B?L2NtQUt2L1hnYUs2NzU1eTVVbTNXakswcjNCeXREcVV3aHYzQmNGazYy?=
 =?iso-2022-jp?B?eS82NEdqaXdjYXhYbXoyL3NmY2s4U1o0QmFKZVVzVGpIclpIeWtBc3Fm?=
 =?iso-2022-jp?B?OTRMQXRMQ1gzdzd3cjhUQmVJb2hFcG0yNFBkKzFoQi9nMVhIRnJFbjZh?=
 =?iso-2022-jp?B?U2pzM2xYdlRQQzNxbDY4aTlGWEdGZDlVQTVqNHRxUWhsdEhNdkQ4dzUv?=
 =?iso-2022-jp?B?VHBWQUNlYzdCUm5ZNUtLZnNma1Y5ZjhQeVkvdkk1TmlTTk0vQkRFUXBB?=
 =?iso-2022-jp?B?R0FqUUZHKzJucFVNdk5hVFBlRGlscTFLejZhUHBsZFJNcXdWbldUMzkr?=
 =?iso-2022-jp?B?cUlMSnZ0MTVoK3pLV3Q5eHZDQm5lcVp6Ny9RdnZZeU95KzdXaTlZajFJ?=
 =?iso-2022-jp?B?bTVHQXBvODkreGtlRkxaRzdZWXJNam5wRDVBNXRwQVBOMXRoVnVZUng3?=
 =?iso-2022-jp?B?K3M0L0tnNmZnd1NtaHNvOWF5dzY4clczdUxhVmtZanlVVlNYVXh2N2Fs?=
 =?iso-2022-jp?B?WVE5TktJVkgyN3o3bmRiT0x4M3ZwcmtrdnZnNmFUOW9yWXVMOUJNVzdL?=
 =?iso-2022-jp?B?THI3bG5yQlA3QldUVG0yK3NxY2tHTm1aRzZJMzNSRS8zZkd6MUxJYmJ5?=
 =?iso-2022-jp?B?eVlBMnZ2MGhWYU1IMlVLanJ0bUdVaHk4cFNybUJJOFlXenljUVVNQ0Vk?=
 =?iso-2022-jp?B?UU56bGE3WnREUjZ3UFRRcEwveHdiY3duT1plREFhekJGU3BBR3BIS1Za?=
 =?iso-2022-jp?B?SWFZZEo1dDc0anorTjJLN3VOdzVPTU5Fc2ZuaUpZNjAyU203Y2h6NDBk?=
 =?iso-2022-jp?B?WERJQWJNb0dudUJzWFJ1cHhEblZOZ2ZxV1F6NVQzZS9sQ0VmQU1NQXdG?=
 =?iso-2022-jp?B?d2RXNm1qUzB2a203emtRbEZkd3E5ZTliaU5NUlBCbXhkeVJGOFA0b2lo?=
 =?iso-2022-jp?B?RTIxT2MrQzNiUkNVTDhUbWdMWS9lUmZGelBmUWRsUFJoVVM5T0VwRytH?=
 =?iso-2022-jp?B?Q1NDRm5jTUJhYnBsV3hJZjVPRlEwa2FGOFBGRW5MaGNRKzdJNHV4R2Vx?=
 =?iso-2022-jp?B?RzE1NzgxSlA1cTBkWUNhZWYrVFoxRElhNzZIb2JURERtVEFkRjVGOXdM?=
 =?iso-2022-jp?B?OGNtT2RXOFpVam9hQW9scUpxSHR3WHFYUXcwT1hiaVBrT0Q4Q1BhU0FS?=
 =?iso-2022-jp?B?QXNxNHhMZkNOaXJoeXJLZnA5RnUrcUpTN014SUlyR20zTnJqL01Ebi9r?=
 =?iso-2022-jp?B?cFZocTBna3p2ZWRVOTNSOGp4bUpMb2tRTEwrS1IzNHgvSGdnT3pFMWJY?=
 =?iso-2022-jp?B?T2xwMWUvcXhZbzhlRHVMdnZydDJuRGRnWTFiZTcyZTNNSWVtc0VtWE8x?=
 =?iso-2022-jp?B?cFhIVXBFL1BrTjRWY1VuNE9LV29WamdVSkdoSjJ2WXZWdSttemNtTmh1?=
 =?iso-2022-jp?B?cjBxTmk2RldpOENYUllaRUtqMjU0ZG5sc2tUR0NNNjhiSkJtNzU0VEtO?=
 =?iso-2022-jp?B?dVdMdERkdGt4VUxiN0REUXlpY1Q5ZXdPdFRVSGpndnZVYk5BWUZ0UFJP?=
 =?iso-2022-jp?B?UnJOc3Vsc0lIdFRGaVYrSHZJb3BhVStxaXc4VWRwbS9OY0lGWlVtVGpu?=
 =?iso-2022-jp?B?amlUbFBCeWdiVEhEUnJIVCtBWHNVVlFMTGNDL2o4K2tQekcrZnFyRlJq?=
 =?iso-2022-jp?B?Rk90Y1RoWlhmbkplMUZISE1zMXdJM2ZGbzM3ODdxdTJRMW05U3lDcXJ4?=
 =?iso-2022-jp?B?TTZiRXBPMXJnbmx3Umd0a3RRZ2IxY0t3UXR6Nlo1a3VMWEwvWlN1Sy9C?=
 =?iso-2022-jp?B?Y0xXWkhaN2ZOODZuUUtpQ2lRUjZjaXZZWTZkTkdWcy9OL2V4SC9SWm1x?=
 =?iso-2022-jp?B?YjdPUTBTejhBU3ErdlhpMU40Yk9CNDkrNVk4ODVSaDYrS3RxdkRQRFZV?=
 =?iso-2022-jp?B?VGVUNFdNdVBDdnlQbWJYWmt1Q3RVcElw?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?UlNIeWxNVmozQjIzSWFIeDc1cWdyNnFSS2RHQmtNSE13QllDejJHWUVB?=
 =?iso-2022-jp?B?UjZkbC9melMyZ25Mbzg1RVQ0QTRJSGhDQ0dSN01ZUUNLT2dsVlRieHYz?=
 =?iso-2022-jp?B?aThjT1VjRFdRYWl0aWZiL25IZ001enBxNlJvSUhQM0V3d1hBa1k0ZUZr?=
 =?iso-2022-jp?B?c1ZtRFpmejJoZjBpb1M2WjRBMnZONkFWWE5YVFpxcWZJWmd2WlU2c0xn?=
 =?iso-2022-jp?B?TDYxcTVGVU93V3pPRm0rUk80bW5yZTF0QndxRVRucnBzUHkyb0poTnB5?=
 =?iso-2022-jp?B?YXA0eHVEallnNkNEMmhPd1o0bU0zWGx2QUUvcWFNUDVOaGhNTjdSVHlj?=
 =?iso-2022-jp?B?dC9kMjA2bThTM2JMS3VYRzVNMWhWUmVOTngwYVNiSnBZMG9UU2VmZEx1?=
 =?iso-2022-jp?B?R0N6Z1l2UEh5OEcyU0Z6Zmp6QmFmTFFNNVVuc3NkUnVJWHI4WGJmWmtJ?=
 =?iso-2022-jp?B?K2tEOEVIdnIvNitqa2cyUUE2NitTTG9wU2FCbUl6c2YwT2FkSUt5V29M?=
 =?iso-2022-jp?B?V21YVFJRaXBDSVZIQVpQQWl5MXAwY1hiOEljU2VkTHpPT1RTM3ByeFRG?=
 =?iso-2022-jp?B?cmdOeG5YVGZlQURrZ3ZXbmk4Kzk0ai9lUk5xQ0lnVk01Q0w1ME9VTk83?=
 =?iso-2022-jp?B?VGQ1aS9UbXp5ZytpaDZLMERqdjdGNzk4citYWG1BVzdWOVdnaFphRUxH?=
 =?iso-2022-jp?B?VkJhSzdYWWc3c0gvSFcxK3UzSDFBL1E3M0dqcEphbGtXRnRmRk4rSmYz?=
 =?iso-2022-jp?B?Z1F0TFg3VzBTaU1BcWJSVS9nM0EyWnhtK3M5cVBHVWM2U3lSeDlWLys5?=
 =?iso-2022-jp?B?Szc5S2JYWFNhMkZjNVdnM1NqSlVhb3ViMlVBeTVvQkxiU3hiMjFndlVN?=
 =?iso-2022-jp?B?b09UNDUvdXNNTXZ3bXJ4VzYyYlh3K01vdWV1a1h0L1AwSGNSYUowTHlU?=
 =?iso-2022-jp?B?amswT2JJa3M1SStxem9admRUZ2NCQWVxUzlBUUkzZGRsT0h0OWhYQlVL?=
 =?iso-2022-jp?B?MzI0d2U3Ryt4UUlyajl6dU13UGtvMUhoWk5OT0tjVCtlOWlTemU2RmZt?=
 =?iso-2022-jp?B?cWQzbkZFaThqYVRlZHVDVUFGcGtRMG1XamZiUEUvc2piMGd6ak4vMUJO?=
 =?iso-2022-jp?B?YmF3SnJVRHJ3OURKTElwR3hjbFRSWlNKM1VBd3IyQXhEYnlDQ2JkYkZO?=
 =?iso-2022-jp?B?ZlpWYUNNUXBBN09vOU9UWFNNa2xXQUJkTkt4Sjl3R3orSzNvN1NFS0tY?=
 =?iso-2022-jp?B?NzdPNTR5ZFdOTkxidUNqQXg2Ulg3OC9JS0RaSExESXYrYi8vWVJ1VVo1?=
 =?iso-2022-jp?B?NGJwMVFmOFhONGhwSWEzcVBHSVBsL0g4dWxmbjhWaGRiUTM1MWFMRFFK?=
 =?iso-2022-jp?B?MlF4NlgrRnFpemU1NEVxbUlYTGJ5ZG1Ddkc3SktCNHEvcGxUamtJZHpU?=
 =?iso-2022-jp?B?eEpXOWJOWFVzRVNZcUc0TnBKYTlVM2dVZUpOT3FieWRYbWNVL0Q3OGpp?=
 =?iso-2022-jp?B?eXFKZkxGTHg0VDBkNWplZGgyWW52RlRQa1pxdUY0bnpHUlZVa00rL0Uz?=
 =?iso-2022-jp?B?L1YxZWF2Vm5oQTdWZnQvWFJXMFlsTklHNTh4dUpaQWs4dnArdnR5Vkc1?=
 =?iso-2022-jp?B?MWd3dkYzRUp1WXA1blFxWGdoRVNDR0o2MUtZc3JKOWVWUWV6K2hRK05z?=
 =?iso-2022-jp?B?RUxhb3pZTmxyVlRObDhCY1dmLzVkTW9yUzg4RHpZWlh3NzdOYnNja0s3?=
 =?iso-2022-jp?B?UnVJSUxhRnhYMGRwcnhvc1I5a09LVGovZytIWUFad2s3ckY3bndlZ09n?=
 =?iso-2022-jp?B?ZjJrN1NDQ0VhdTRaZk5RMXM5TklnYTcvYjlYZWk2cEgvTG5GWXdUWkIx?=
 =?iso-2022-jp?B?MXhqYTZRaVB6Q2FieXNJWHRXUmRkZnlPRGhDYnh2UDJUUkZTdTl0dmhO?=
 =?iso-2022-jp?B?bFMzN2RyaEdNRVg2TnBHRlB0b2VOY1VwakFtRndEcllNRUxqbFJCVDFt?=
 =?iso-2022-jp?B?MXgxRHlGcHM0djdUTTJzSHNCWjBaK0JNVlpRdU5aZ0xpY2I3bHo4YWtB?=
 =?iso-2022-jp?B?RkVQclk4SWZ4NWVubTBEbUQwN2RXb3JVc3RFc1VKT3VNUzBGM05QYmpr?=
 =?iso-2022-jp?B?QnJmZzUrRVdBRnlKVDViZDV6em90Qnk1WnF4V3FLSDN4cWdUM01HSDN0?=
 =?iso-2022-jp?B?YXZsa3JkVlFlSlpXOUZkWVR5b0ZJOXgra0hBK1ptcmJha0JEb2ltMTVM?=
 =?iso-2022-jp?B?ZUtkR2hPY091QTJPR3N6dzM3Mkt4S2FoSEhZTTZ5eFdxSWsxWVZwQ1dQ?=
 =?iso-2022-jp?B?dTRFdVpZZXBzVHhURjdvb3FiL216L3Z4NkRmUGFFZ3BNbnVBYVBWQWpQ?=
 =?iso-2022-jp?B?UlNGMUk9?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a613b8fc-1861-4873-c9f1-08de30a39f1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2025 06:34:03.9961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I6YW0Eh05K9knSxdQ2wwKbXSJKBq1pSShu4Q3ByvtqUf+QCn2G9MjWcFdIrSDcU+4bzUxOMfB1qwd6dgvsTbAuXt+cTuHvxzDFUW/hhnkV8JLURX3NZCP22+TplgwiqM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12758
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 01 Dec 2025 06:34:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20773

Hi Gourav,=20

Thank you for the update. I understood.=20

Yes, as you pointed out, there is some issue when all tests are running tog=
ether.=20

For each audit test case, we will update configuration file and restart the=
 auditd service at preTest phase.=20
In qemu-amd64, for one test case this service restart is failing, so leadin=
g to test case failure.=20
It may be due to the conflict from other test cases as it is works fine alo=
ne.=20

Thanks & Regards
Shivanand K

-----Original Message-----
From: Singh, Gourav <gourav.singh.ext@siemens.com>=20
Sent: 28 November 2025 23:34
To: kunijadar shivanand(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <Shivanand.Kunijad=
ar@toshiba-tsip.com>; Kiszka, Jan <jan.kiszka@siemens.com>; cip-dev@lists.c=
ip-project.org
Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <dinesh.kumar@toshiba-tsi=
p.com>; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B""#D#I#T#C!{#C#P#=
T=1B(B) <kazuhiro.hayashi.f74@mail.toshiba>
Subject: RE: [isar-cip-core][PATCH] fix(security): add libpam-systemd in De=
bian trixie

Hi Shivanand,

No, I hadn=1B$B!G=1B(Bt executed the IEC layer tests on qemu-amd64 initiall=
y. I only ran them on x86-UEFI and shared that log file.

However, I have now executed them on qemu-amd64 as well. I also get one fai=
lure. The issue appears to be related to the auditd service. When the test =
is run alone, it passes, but when executed as part of the full suite, it fa=
ils. This suggests that auditd may be in an invalid or inconsistent state d=
ue to interactions with other tests in the suite, causing the failure.

Thanks,
Gourav

-----Original Message-----
From: Shivanand.Kunijadar@toshiba-tsip.com <Shivanand.Kunijadar@toshiba-tsi=
p.com>
Sent: 28 November 2025 15:07
To: Singh, Gourav (ext) (FT FDS CES LX PBU 2) <gourav.singh.ext@siemens.com=
>; Kiszka, Jan (FT RPD CED) <jan.kiszka@siemens.com>; cip-dev@lists.cip-pro=
ject.org
Cc: dinesh.kumar@toshiba-tsip.com; kazuhiro.hayashi.f74@mail.toshiba
Subject: RE: [isar-cip-core][PATCH] fix(security): add libpam-systemd in De=
bian trixie

Hi Jan,=20

Just an update for IEC layer tests on trixie image.=20

I've created trixie based security image for QEMU by applying this patch an=
d executed IEC layer test cases.=20
qemu-arm64 and qemu-arm --> No issues, all tests are pass.=20
qemu-amd64 --> One fail test out of 44. It is passing if I execute it alone=
, the reason is not know yet.=20

@Singh, Gourav Thanks for testing.=20
Let me confirm, did you execute IEC layer tests on qemu-amd64 and shared th=
e log file?
=20
Thanks & Regards
Shivanand K=20

-----Original Message-----
From: Singh, Gourav <gourav.singh.ext@siemens.com>
Sent: 25 November 2025 16:39
To: Kiszka, Jan <jan.kiszka@siemens.com>; cip-dev@lists.cip-project.org
Cc: kunijadar shivanand(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <Shivanand.Kunijad=
ar@toshiba-tsip.com>; dinesh kumar(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <dinesh=
.kumar@toshiba-tsip.com>; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$=
B""#D#I#T#C!{#C#P#T=1B(B) <kazuhiro.hayashi.f74@mail.toshiba>
Subject: RE: [isar-cip-core][PATCH] fix(security): add libpam-systemd in De=
bian trixie

Hi Jan,

After applying these changes, the IEC test suite now passes all test cases =
on the Trixie image. I've verified this on my end, and I'm attaching the re=
sults log file for the test suite run on the cip-core-image-security Trixie=
 image.

Thanks,
Gourav

-----Original Message-----
From: Kiszka, Jan (FT RPD CED) <jan.kiszka@siemens.com>
Sent: 24 November 2025 22:07
To: Singh, Gourav (ext) (FT FDS CES LX PBU 2) <gourav.singh.ext@siemens.com=
>; cip-dev@lists.cip-project.org
Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>; dinesh.kuma=
r@toshiba-tsip.com; Kazuhiro Hayashi <kazuhiro.hayashi.f74@mail.toshiba>
Subject: Re: [isar-cip-core][PATCH] fix(security): add libpam-systemd in De=
bian trixie

On 24.11.25 17:30, Singh, Gourav (ext) (FT FDS CES LX PBU 2) wrote:
> Hi Jan,
>=20
> Regarding customizations or configurations for the `libpam-systemd` packa=
ge, which provides `pam_systemd.so` - a new systemd mechanism that replaces=
 the traditional `/run/utmp` for tracking active user sessions in Debian Tr=
ixie - it is necessary to ensure that `pam_systemd.so` is included in `/etc=
/pam.d/common-session`. This replaces the traditional role of `/run/utmp` i=
n session management.
> Ref:=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flist
> %2F&data=3D05%7C02%7Cgourav.singh.ext%40siemens.com%7C5ea16736126646eaff
> a708de2e61bfcb%7C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C6389991945
> 77586025%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuM
> DAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&s
> data=3DNcc3WXjAHFJcq6EwJp51MriY3nUng4S4v3CQsJQjVe8%3D&reserved=3D0
> s.debian.org%2Fdebian-release%2F2024%2F05%2Fmsg00150.html&data=3D05%7C02
> %7Cgourav.singh.ext%40siemens.com%7C69f7415c2bc3402b8cde08de2b77b21d%7
> C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C638995990271096290%7CUnkno
> wn%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXa
> W4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DzbwdGBW1zzz
> p3xN5q0UW3qN5o1MXmzbBmJv3uQdILhY%3D&reserved=3D0,
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fddp-
> %2F&data=3D05%7C02%7Cgourav.singh.ext%40siemens.com%7C5ea16736126646eaff
> a708de2e61bfcb%7C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C6389991945
> 77612895%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuM
> DAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&s
> data=3D9bItOs3oVHo0Qykqi7KxgyttX6N5a7%2FZdnouxAB66Zs%3D&reserved=3D0
> team.pages.debian.net%2Frelease-notes%2Fen%2Fhtml%2Fissues.html%23the-
> last-lastb-and-lastlog-commands-have-been-replaced&data=3D05%7C02%7Cgour
> av.singh.ext%40siemens.com%7C69f7415c2bc3402b8cde08de2b77b21d%7C38ae3b
> cd95794fd4addab42e1495d55a%7C1%7C0%7C638995990271126607%7CUnknown%7CTW
> FpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIs
> IkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D5ry3XapBLPScmMpiz5
> bdwF%2F9MVx0%2FG6reUH%2Ba5pYxXA%3D&reserved=3D0
>=20

This all makes sense so far, and if no one complains, I will merge it soon.

I furthermore assume that our IEC testsuite will "just work" (again) with t=
his applied, right? Switch-day for the CI to trixiw is now Wednesday, or mo=
re likely Thursday.

Jan

> Thanks,
> Gourav
>=20
> -----Original Message-----
> From: Kiszka, Jan (FT RPD CED) <jan.kiszka@siemens.com>
> Sent: 24 November 2025 12:21
> To: Singh, Gourav (ext) (FT FDS CES LX PBU 2)=20
> <gourav.singh.ext@siemens.com>; cip-dev@lists.cip-project.org
> Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>;
> dinesh.kumar@toshiba-tsip.com; Kazuhiro Hayashi=20
> <kazuhiro.hayashi.f74@mail.toshiba>
> Subject: Re: [isar-cip-core][PATCH] fix(security): add libpam-systemd=20
> in Debian trixie
>=20
> On 24.11.25 06:06, Gourav Singh wrote:
>> In Debian Trixie, /run/utmp has been removed, so traditional=20
>> session-tracking mechanisms (used by w/who) no longer work.
>> To restore secure and correct session accounting (needed for=20
>> enforcing limits like maxlogins to comply with IEC 62443 CR2.7_1), we=20
>> can add libpam-systemd.
>>
>> This ensures that PAM can register user sessions with systemd-logind,=20
>> aligning with Debian's design for Trixie.
>> See Debian-devel discussion: "/run/utmp is no longer provided in=20
>> trixie ... replacement mechanism provided by systemd."
>>
>> Ref:=20
>> https://list
>> s.debian.org%2Fdebian-devel%2F2025%2F04%2Fmsg00011.html&data=3D05%7C02%
>> 7
>> Cgourav.singh.ext%40siemens.com%7C13545a99022f43a55dce08de2b25d0fb%7C
>> 3
>> 8ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C638995638612273708%7CUnknow
>> n
>> %7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW
>> 4
>> zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DtNzGl6b239zR
>> 7
>> GFA5WPQwQwSi0fRIhXp5hQchE7pxKw%3D&reserved=3D0
>>
>> Signed-off-by: Gourav Singh <gourav.singh.ext@siemens.com>
>> ---
>>  .../security-customizations/security-customizations.bb         | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git
>> a/recipes-core/security-customizations/security-customizations.bb
>> b/recipes-core/security-customizations/security-customizations.bb
>> index 717e2d3..d8fa22b 100644
>> --- a/recipes-core/security-customizations/security-customizations.bb
>> +++ b/recipes-core/security-customizations/security-customizations.bb
>> @@ -25,6 +25,9 @@ DEBIAN_DEPENDS =3D "customizations, sshd-regen-keys,=20
>> libpam-google-authenticator,  # - libpam-passwdqc: Preferred for newer D=
ebian releases (post-Bullseye).
>>  DEBIAN_DEPENDS:append =3D ", libpam-passwdqc | libpam-cracklib"
>> =20
>> +# Append systemd PAM package to limit concurrent sessions in Debian=20
>> +trixie DEBIAN_DEPENDS:append:trixie =3D ", libpam-systemd"
>> +
>=20
> So, no configuration needed? And does this obsolete any other dependency =
in trixie?
>=20
>>  do_install[cleandirs] +=3D "${D}/etc/ssh/sshd_config.d/"
>>  do_install () {
>>      install -m 600 ${WORKDIR}/ssh-remote-session-term.conf
>> ${D}/etc/ssh/sshd_config.d/
>=20
> Thanks for tracking this down. I suspect that our certification efforts a=
re still focused on bookworm as baseline, but this is an important step ahe=
ad already. I also hope we can soon switch CI to trixie, currently waiting =
on lava-docker updates on the workers.
>=20
> Jan
>=20
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center


--
Siemens AG, Foundational Technologies
Linux Expert Center



