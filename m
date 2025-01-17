Return-Path: <dinesh.kumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC12C02185
	for <webhook@archiver.kernel.org>; Fri, 17 Jan 2025 10:42:08 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.8021.1737110524676776265
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jan 2025 02:42:05 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: dinesh.kumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 50HAg2Ok1471217; Fri, 17 Jan 2025 19:42:03 +0900
X-Iguazu-Qid: 2yAb5TJleELMx0qGFV
X-Iguazu-QSIG: v=2; s=0; t=1737110522; q=2yAb5TJleELMx0qGFV; m=RDeoTNtdLEmMv2GJI6gui+YTJFM3fQYcJIZAcp1IUVg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 50HAg0Iq195196
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 19:42:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rxybHsSebHCOntKvxQ1TAHa0tCEjia6u6heSUEdl0LorsJzkwZoDkal013k9g8+CKUP45aduBtHcVzdd0/6GjcsgOmuPtaxbSE6A3Ki5qTI8jOjVT7j2sksnhftgc/cDu6p7B5PUYyyBIp+fCSwgoXpWvw/nE+wQuip9PPrtZ1H4TG+9Iq3kWqVqRvL16WaKpRBf17IeRwG9uINW26JOL4MedTS0cGaHgaRFPy/lk2wzLKPkw6EVJ//x+u698G93mVlu7SWWguzxSjWlxeCrhQHahmU8YgQypsUFLEk6//Tw/Z+NZAhEGWUAHAPV06XZ0mAM23CioU9ktPCSiagb1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfXtUPOzfU2f5FDiV0LoXNBJAyRTyb/zGECOCzA22XU=;
 b=eegm0EcYE92WpAq/hU/6wojax2tfsRAhQ3DW6sEex8ArPN8YcqDX2jt0J34DLepYm7BKukthtbfq+ydL95KAIChD8D+BqjiiFw5bAqRo1Emvb4mEqooNJ9pog5NtNn6E+R5/ZT7YmBbISkMSFDu9irTCW5plJAjujlWO+EsxU1JeXyubtpet+ilh3FZUvOPen4Tqs8ixDaZcvYMoOx+O6cPC1H8Sl8EMiogMyRvT7bnePgDxcgqiN/vOLg6tOiKW/Evc4zVIpccRJrt7k472rjKQrXkMt2NpY/Z+RdtnTyOhWLOQVLDHPOYVm2G90TuwqyZx/Ej80IH2u6eSbO1XXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <dinesh.kumar@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <kazuhiro3.hayashi@toshiba.co.jp>, <cip-dev@lists.cip-project.org>,
        <Sai.Sathujoda@toshiba-tsip.com>
Subject: RE: ltp (syscall) failed test in CIP Security image with
 isar-cip-core v1.6 on M-COM
Thread-Topic: ltp (syscall) failed test in CIP Security image with
 isar-cip-core v1.6 on M-COM
Thread-Index: AQHbUuTAhee4QvOabkGKuX6gapV/KLLvWeRwgCiiEZCAAvIAEA==
Date: Fri, 17 Jan 2025 10:41:58 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSZPR01MB85158D80663768F0ECD9D96CBF1B2@OSZPR01MB8515.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103AAC4C7533384E6C3CE8CC2072@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <OSZPR01MB85159B1B29203FFAC3458D6ABF072@OSZPR01MB8515.jpnprd01.prod.outlook.com>
 <OSZPR01MB84010B4C962BC73DD1466779B7192@OSZPR01MB8401.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSZPR01MB84010B4C962BC73DD1466779B7192@OSZPR01MB8401.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8515:EE_|TYWPR01MB11104:EE_
x-ms-office365-filtering-correlation-id: 7e320d0b-60a7-4f2f-6b40-08dd36e391e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|8096899003|38070700018|7053199007;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?Umo3NWhZblJhNzgzb3JiYWVmaFBYblRpNmRWbCtsRFhYeGZETU1OUVQ1?=
 =?iso-2022-jp?B?Y08xamF5UUU4clR6NDQvbXFobU5vdHNzSzloK1lCK3dRRUZYWGhsNHNM?=
 =?iso-2022-jp?B?c0pmVnllUUNtTzlrU1JydnA3RFZSYUUxdTBYUmlDaWFQdUY1ZVduMXoy?=
 =?iso-2022-jp?B?dkZxRWhCSXRVdFBqRDB2dERSdGtNVTRibngxRDZlTlpnMnZiTHBxeGlE?=
 =?iso-2022-jp?B?M1c4YjRGY3lrM0hxUDZycW1NbWE0SlFQVnQwODlITUJpL3NQS2F5RGV6?=
 =?iso-2022-jp?B?UGFLUGpsazJFSW5BMHZYMENDdTR5SHBRVXFCbUhaa0V1dWJaTUlhZkJr?=
 =?iso-2022-jp?B?N3BITm40MUxFbmRyQTlraWN6Wk1KZVJBbnMydE5BOElGejdSR0VMVllu?=
 =?iso-2022-jp?B?MmZYaGx4S2E4d0p6SjcyZnhLejNLNHRFOTJHQm5mYWFnN0JGWTNIY1cr?=
 =?iso-2022-jp?B?R1EydjBoZ0JNTk5McE1iT05VeUlsRXNmNzA1cWd4NFlzTWxkRUNqVklI?=
 =?iso-2022-jp?B?SGtXMDVNRHFZdXZsaXZTS0tuM0kyV0N5WGdQOFNEOHY3NXZwTXU3TjdI?=
 =?iso-2022-jp?B?UnRSM1RWTHNmaEYyWmRwQjVjRTl6K1lnMStkVUhPN3ZJUEtQaEVlQUNO?=
 =?iso-2022-jp?B?WVhkKzBvZVlROVJDUmZ0TEs4YWlDRlluL2ErTjlzek1YQVVKVDVsdStj?=
 =?iso-2022-jp?B?aVpOcURnSGp1TXZJbFF4ejhmQS9DWTE4ekYvbFVtc1ZwT05mcjlsbTZJ?=
 =?iso-2022-jp?B?dVZFbU1EWmF1cjJLZEZkd01KMkVDOTlUSloyNTg5ajYrQ0YwWnVTQVJK?=
 =?iso-2022-jp?B?N2NkS0pjQzJrc01MejlCYTczZ05rZ0U2MHR1dk1EOVFodHRJbXp1Y2xi?=
 =?iso-2022-jp?B?eG5tR1RrZHM5STVuK1Z1RUhDelpWQUdnWWJlQmxuZkFYQzNINUNxY2Ny?=
 =?iso-2022-jp?B?N24vdjUvenpvNmtpWWdOSG1Ud3VTcTc2ajZndXJFS3BPTTZSd25xSmZn?=
 =?iso-2022-jp?B?OE9OWTJxOW9xS0xlblJZZ0E0ajRHZ1NPRTV0U3R3Vkd2L25Rc2x5a3h6?=
 =?iso-2022-jp?B?R24rMUE0S0tRYytaQVVKNlhhaWtTTWxjbDdEZ0VWUjdmMUE1bVlpbnJm?=
 =?iso-2022-jp?B?OS90T0NzM09rVGdSM1YzRUdQWXljem9mTUV5Vmg0Vi9ReittdXBBMlJn?=
 =?iso-2022-jp?B?NFdUZ2NrRm1GTGtVcDF0ekZ0VmJQVlZXWWlXQjRqN0NVd05rWCsrWjcx?=
 =?iso-2022-jp?B?R2dxb2o0WVBYUjhPUDRtMEpLUzZSYmswQzRtOW5KZ2cwTUxQck4zNGpl?=
 =?iso-2022-jp?B?OEtDZHRnTlNJRXBHNW9zb2x1amQyMnJ2aEsreENlZVdSWFRhc2sySHR3?=
 =?iso-2022-jp?B?djg0WkxKSG5XUFNYWnRRTU1YdGpBb2t1bk1PVFUvZGQ0aGoxdU5kMGlw?=
 =?iso-2022-jp?B?UjRZdnZ3SFdYV0hLSENqV0I5YnRhb2IvVzdhdDdFN1pqNkdsNDQzRkFl?=
 =?iso-2022-jp?B?UnlKRXBNK3Qxd0pPL1g3VUxpRjQxMkhiOGlIek8vQnZ2MkttcXNVWnBH?=
 =?iso-2022-jp?B?VS8rdjV1MllmUDJ1NnNxQ2RURldoRXhPdGM2YThDZXorUERpN0xpQ2Qz?=
 =?iso-2022-jp?B?MDFHWk0xZnVkUVJCbUVNKzhjcXBqRm5Bd0ltbUFKUHEyK1YzalpaMVY4?=
 =?iso-2022-jp?B?UjZtYy9zeUt0MXRPNFRBUE0vRWJ2SHV1clBNNlhwZmdIcUl0RmFNdzRr?=
 =?iso-2022-jp?B?RkdpVGx3NlRZVjZkVGR0MlFMTFFEVi84eUp3N1VZQVhpRU4rdGs4SGlM?=
 =?iso-2022-jp?B?NzY3N3JUSTV0WjU1ZFZNWHRqWWMyMWU5WFVDZlZRbjNFRGY0SkhMNkY2?=
 =?iso-2022-jp?B?NG95ZWhveW1HYmNicDVDN3h5elRkc0ZkK3d3YWMzRjdqWDNKQVJqY1hs?=
 =?iso-2022-jp?B?UVh5TVI4Z2NPZTIxeVZCUWpucnExZ1BoeVVraWdxRGwvZUV4T3ZVdWNZ?=
 =?iso-2022-jp?B?c3NxS21FMzVwVFFoWWJ6aXJKdDhCdUFlMGlLOVZkWksxNVNFbDgvWEd4?=
 =?iso-2022-jp?B?SlE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8515.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(8096899003)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?VjYvRDRiaEhYbGVGdkJ4a01OelJ5VzdSNWFHZlRuNnVoWUMrZTB3MXFS?=
 =?iso-2022-jp?B?emcwMVJwWUczWXNJeGZlNExJL2FhQnB2ZnA1c1lFaEEvMUZKVnVDcldV?=
 =?iso-2022-jp?B?SHFhdElrLytRVFpIVUx1NFdJV0Y2OS9kVHNRSko3WHU4MEhaR2xYV2pw?=
 =?iso-2022-jp?B?dVVtcDBpT3dDQWpOY0pKWXppQUU1cXNQV1JZem91NFpRUU9RNnZHRFhT?=
 =?iso-2022-jp?B?Nzk3VGhzOE9ZNitkVHVXRTluaVE3dkNhS0llSzhNSDhmOXpuK3Jhajhw?=
 =?iso-2022-jp?B?NzdoL3lNeGVURjZpR2I3TjlySkN2T2s4OEdOTk05QzVvdzJadGVkMmlO?=
 =?iso-2022-jp?B?QVB3eE5wTDNxc1BYMnQrdTU3TzQ0MGtPbVFlaTNXN1E3bGY3a01Pc1Jn?=
 =?iso-2022-jp?B?bWhuOHZ1ZXlqNitVWThxQ2NNZmE3azJuQ3ZzL012cUVmWjBEa216dm05?=
 =?iso-2022-jp?B?cERYR2pkR1U4U3VsWUJHaHpUNEJHdlhVZVdML3AvQkt1bURFRkFFdzVq?=
 =?iso-2022-jp?B?QkFyZXNoL3hDN1k0NE9RdVArdzNQbHYxRDROanU5ZFVtanB0M0VndE8x?=
 =?iso-2022-jp?B?dGRVVlV0ZzhOUHFZSXNBbzZvSGtSMCtsT2hjS3lUTWl4NnZLWnl3cTdG?=
 =?iso-2022-jp?B?bFVkVFQ1UGExS3RMMWwzN1lVN0FBTTVuTjhBK3dwc05TdkZLanZ6eFFo?=
 =?iso-2022-jp?B?MjVUMmxyMEhsN0VBemVTVHdLaUNmazR6emJlNDZ1MnltNy9nSk9pVmtn?=
 =?iso-2022-jp?B?VlRhVEZmdXQwRGhQQkZhZjFtWDNJcUVBbnpxNHFLeXJwMWZ6TDVoUlBX?=
 =?iso-2022-jp?B?L2tMa01VSlNwNUpxYmNrMHpnamZNeFphZUV3R2VqVlJqMmpUNWJBeU8r?=
 =?iso-2022-jp?B?Q0hJczV4eEprdE9WM0NlVzlHelV2YzhhczJFQ2dXUmFCbWdKNUZ4OG10?=
 =?iso-2022-jp?B?eHdQWXVRMUJmNDdsMUFwNlE0VWNWcE1TVnJWWndBYzdadVBuRUNHUW5u?=
 =?iso-2022-jp?B?cmpLK2pMa043SnhKMW9rVThNTTlyL3R1a3g0dlVGaVIyV1E4RW9jMVQz?=
 =?iso-2022-jp?B?VmE3aXhsNXV5OHVlYW1OL083dURrVjl5M3YxWTRZS0tLUGZDdklKNm51?=
 =?iso-2022-jp?B?OWUvaVR4b0hWZUJxTjVMZUVUbHQ1S3dzQ290N2F5VkxyWUo1WDFkUExV?=
 =?iso-2022-jp?B?OW5iVkdXZmFPeTVReWx2NjNmQlNMVU5LTkpwWUdYZU9sN0Z6L0dkaUR3?=
 =?iso-2022-jp?B?Qlh4MWNnbTJoSjRYL1B2Mk1CcWs2Tit2R1NXNjUxVHZrS1pLRVV0UjhO?=
 =?iso-2022-jp?B?SVkybTlRUWpuaFB3eDhYMlNDeDhlMG5QVURqdTBUdUh3TGc4MTBnS1hW?=
 =?iso-2022-jp?B?MEJhZWR5S0ozQ0FWRHJDeHhhTFdJU1VHdllwUVh2VzFCdHlFcjJKUllq?=
 =?iso-2022-jp?B?a20rM1p1cnp6d3JQQ245TkRJZ1A2K3E5OVRGOEJOTEk1SW56OW5qZTdE?=
 =?iso-2022-jp?B?WWY2SCsvNFg0dm04UGZqWlJqU2pzMjIzbVUwTWxZS1pqZUp6TzdrUTlx?=
 =?iso-2022-jp?B?MkVhelZJRkxCMEpQQVZnSWp5MXdSTko4QWxRVXRmbDZxZGs0YktEQ3M2?=
 =?iso-2022-jp?B?TEdTenV2UXFIelhVTVY1SUdFamVsanZzNGRKOURPS1I0ZWFPb2Rzbk9N?=
 =?iso-2022-jp?B?ZmU4UzRoRXkyMFpUL2hJQ2dlUjFRZ2dTTXUvajROSWtHZ3FLMFhTT3hO?=
 =?iso-2022-jp?B?bHdQSkI0U29tZnV4Z2lidTVScklhMkhxK1lvdU1jUUlOTEh5QUJ1Q0pl?=
 =?iso-2022-jp?B?WmJQbmdhd1c5dnAvMmlVbkd2aktTSDJ3cFR2N24zS254MnNlamlmc3c1?=
 =?iso-2022-jp?B?UXJyTlAzQWFwSGJoaEZMa2t5ejdqalBjYTJTQVh3NUxoVVJIcjNFcjd5?=
 =?iso-2022-jp?B?ZThpRHlsU3FnZG1QQlRwRmtGQnY4RldxaEtzT05UV3FGLzFteHhiTXBI?=
 =?iso-2022-jp?B?MThTSktiVDIxVmMvQzA2YzhKYjJNQ3hlOXNzOER1RXNXWi9QLzI2UXox?=
 =?iso-2022-jp?B?RkJESnA1VHhmUVZYVC9xSTduZWJLb0dHMFhJUGwrVWplY1VHRkxyaUda?=
 =?iso-2022-jp?B?MDdZUW83NkZFMWIwTFdpNU9scys5cnhRZzBTQ1I1eTNWU0pFZ2ZKd3Nx?=
 =?iso-2022-jp?B?YWozamt4cER4M1RUM1E2bWdYUUlBSTAyYkxSdmZleEhrQUw4VmwyODNT?=
 =?iso-2022-jp?B?MHNHUTNjZWNzQzJVeXh6ZC9UVW4rVXBSeTVhUkVlT3pxNWVLaFlkWFVC?=
 =?iso-2022-jp?B?TXNzSi9vN3VJZ2xFL0s2Z3BSUmtDWVg5Z0ZLME1VaHV0Z0pIaTVzQnU1?=
 =?iso-2022-jp?B?dW0vdUtKTXpDb2psMlFSV1E0VWF2NXcrWTJhWHhDVWQwT1M5RjNmNWwv?=
 =?iso-2022-jp?B?c2UxOVNRPT0=?=
Content-Type: multipart/alternative;
	boundary="_000_OSZPR01MB85158D80663768F0ECD9D96CBF1B2OSZPR01MB8515jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8515.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e320d0b-60a7-4f2f-6b40-08dd36e391e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2025 10:41:58.9423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pjwTcL1ceuW/N4AiOI1u4tDVlOFUZz+ZNRKi1IUCOhscLgfADwxe8S/RiAIn5PLSBCZjg6jO+q+s7zHNh4cS9yeJoLrmTsA00ylYFq7gNQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11104
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jan 2025 10:42:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17546

--_000_OSZPR01MB85158D80663768F0ECD9D96CBF1B2OSZPR01MB8515jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

Thanks for your response.

Sai has added comments in the MR. Please review them.

Please refer my response inline.

Thanks & Regards,
Dinesh Kumar

From: Chris Paterson <Chris.Paterson2@renesas.com>
Sent: Wednesday, January 15, 2025 7:27 PM
To: dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshib=
a-tsip.com>
Cc: hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D=
#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>; cip-dev@lists=
.cip-project.org; ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-ts=
ip.com>
Subject: RE: ltp (syscall) failed test in CIP Security image with isar-cip-=
core v1.6 on M-COM

Hello Dinesh, Sai,

I=1B$B!G=1B(Bve created a MR that adds build/test support for the x86 merge=
d config [0]. Please look for exactly what=1B$B!G=1B(Bs been done.
Currently it adds support to all the CIP kernels.
Do you also want support added for the stable kernel versions?
[Dinesh] I have reviewed the changes you have made. It=1B$B!G=1B(Bs good no=
w merged configs are being tested at least on some targets.
                As of now can you please also enable running ltp tests on x=
86-siemens-mcom target? With kernel 6.1
               At the moment our primary focus is from IEC perspective so r=
unning only 6.1 kernel is sufficient, but if other CIP members have require=
ments to run other stable kernel versions that can should be discussed in T=
SC meeting,

               However, please note that as this setup is not running CIP s=
ecurity image so we will explore options to run ltp tests on M-COM device w=
ith merged config with kernel 6.1 via isar-cip-core pipeline. (This is stil=
l not discussed with all members)
               But this setup is also important in case if we want to compa=
re any failure cases etc.
               If you have any ideas how to run ltp tests on security image=
s on M-COM using Linux-cip-ci pipeline please let us know.

I=1B$B!G=1B(Bve kicked off various pipelines to test these changes. Links c=
an be found in [1].

[0] https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-/merge_=
requests/65
[1] https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-/merge_=
requests/65#note_2298307207

Kind regards, Chris

From: dinesh.kumar@toshiba-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com> <=
dinesh.kumar@toshiba-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>>
Sent: 20 December 2024 16:56
To: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@rene=
sas.com>>
Cc: kazuhiro3.hayashi@toshiba.co.jp<mailto:kazuhiro3.hayashi@toshiba.co.jp>=
; cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>; Sai.=
Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>
Subject: RE: ltp (syscall) failed test in CIP Security image with isar-cip-=
core v1.6 on M-COM

Hi Chris,

Please reply to this email as by mistake Ashrit included SWG.

Regards,
Dinesh Kumar

From: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com<mailt=
o:Sai.Sathujoda@toshiba-tsip.com>>
Sent: Friday, December 20, 2024 7:43 PM
To: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@rene=
sas.com>>; cip-members@lists.cip-project.org<mailto:cip-members@lists.cip-p=
roject.org>
Cc: hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D=
#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp<mailto:kazuhiro=
3.hayashi@toshiba.co.jp>>; dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Portin=
g) <dinesh.kumar@toshiba-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>>; c=
ip-security@lists.cip-project.org<mailto:cip-security@lists.cip-project.org=
>; cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>
Subject: ltp (syscall) failed test in CIP Security image with isar-cip-core=
 v1.6 on M-COM

Hello Chris,

Hope you are doing great.

SWG locally executed LTP tests on M-COM x86 device booted with CIP security=
 image. The kernel used in this image is built with cip x86 merged defconfi=
g<https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/blob/master=
/6.1.y-cip/x86/cip_merged_defconfig?ref_type=3Dheads>. After generating the=
 results, we found some failed tests in the syscalls suite.

We wanted to compare them with kernel test results in LAVA and noticed that=
 cip x86 merged  defconfig<https://gitlab.com/cip-project/cip-kernel/cip-ke=
rnel-config/-/blob/master/6.1.y-cip/x86/cip_merged_defconfig?ref_type=3Dhea=
ds> is not being used to run LTP tests on x86 targets. Can you please look =
into that ?

I am attaching a document with the results summary of LTP tests when run on=
 M-COM x86 device with v1.6 security image. Please have a look at it. I am =
also attaching the failed test cases in syscalls suite.

We need opinion from members if we need to hold back from sharing the v1.6 =
x86 generic isar-cip-core evaluation to BV members in case those LTP test f=
ailures are effective.

Thanks and regards,
Sai Ashrith


--_000_OSZPR01MB85158D80663768F0ECD9D96CBF1B2OSZPR01MB8515jpnp_
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
	{margin:0cm;
	font-size:12.0pt;
	font-family:"MS PGothic",sans-serif;
	mso-fareast-language:JA;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-IN" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:EN-US">Hi Chris,<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:EN-US">Thanks for your response=
.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:EN-US">Sai has added comments i=
n the MR. Please review them.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:EN-US">Please refer my response=
 inline.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:EN-US">Thanks &amp; Regards,<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:EN-US">Dinesh Kumar<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span>=
</p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span lang=3D"EN-=
US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"> =
Chris Paterson &lt;Chris.Paterson2@renesas.com&gt;
<br>
<b>Sent:</b> Wednesday, January 15, 2025 7:27 PM<br>
<b>To:</b> dinesh kumar(</span><span lang=3D"JA" style=3D"font-size:11.0pt"=
>=1B$B#T#S#I#P=1B(B</span><span lang=3D"EN-US" style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,sans-serif"> TMIEC ODG Porting) &lt;dinesh.ku=
mar@toshiba-tsip.com&gt;<br>
<b>Cc:</b> hayashi kazuhiro(</span><span lang=3D"JA" style=3D"font-size:11.=
0pt">=1B$BNS=1B(B</span><span lang=3D"JA" style=3D"font-size:11.0pt;font-fa=
mily:&quot;Calibri&quot;,sans-serif">
</span><span lang=3D"JA" style=3D"font-size:11.0pt">=1B$BOB9(=1B(B</span><s=
pan lang=3D"JA" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif">
</span><span lang=3D"JA" style=3D"font-size:11.0pt">=1B$B#D#M#E=1B(B</span>=
<span lang=3D"EN-US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&qu=
ot;,sans-serif"> =1B$B!{=1B(B</span><span lang=3D"JA" style=3D"font-size:11=
.0pt">=1B$B#D#I#G=1B(B</span><span lang=3D"EN-US" style=3D"font-size:11.0pt=
;font-family:&quot;Calibri&quot;,sans-serif">=1B$B""=1B(B</span><span lang=
=3D"JA" style=3D"font-size:11.0pt">=1B$B#M#P#S=1B(B</span><span lang=3D"EN-=
US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">=
=1B$B!{=1B(B</span><span lang=3D"JA" style=3D"font-size:11.0pt">=1B$B#M#P#4=
=1B(B</span><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-family:&quo=
t;Calibri&quot;,sans-serif">)
 &lt;kazuhiro3.hayashi@toshiba.co.jp&gt;; cip-dev@lists.cip-project.org; as=
hrith sai(</span><span lang=3D"JA" style=3D"font-size:11.0pt">=1B$B#T#S#I#P=
=1B(B</span><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-family:&quo=
t;Calibri&quot;,sans-serif">) &lt;Sai.Sathujoda@toshiba-tsip.com&gt;<br>
<b>Subject:</b> RE: ltp (syscall) failed test in CIP Security image with is=
ar-cip-core v1.6 on M-COM<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN=
-US">Hello Dinesh, Sai,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN=
-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN=
-US">I=1B$B!G=1B(Bve created a MR that adds build/test support for the x86 =
merged config [0]. Please look for exactly what=1B$B!G=1B(Bs been done.<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN=
-US">Currently it adds support to all the CIP kernels.<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN=
-US">Do you also want support added for the stable kernel versions?<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US">[Dinesh] =
I have reviewed the changes you have made. It=1B$B!G=1B(Bs good now merged =
configs are being tested at least on some targets.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US">&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; As of now can you please also enable running ltp tests on x86-siemen=
s-mcom target? With kernel 6.1<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US">&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 At the moment our primary focus is from IEC perspective so running only 6.=
1 kernel is sufficient, but if other CIP members
 have requirements to run other stable kernel versions that can should be d=
iscussed in TSC meeting,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US">&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 However, please note that as this setup is not running CIP security image =
so we will explore options to run ltp tests
 on M-COM device with merged config with kernel 6.1 via isar-cip-core pipel=
ine. (This is still not discussed with all members)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US">&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 But this setup is also important in case if we want to compare any failure=
 cases etc.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US">&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 If you have any ideas how to run ltp tests on security images on M-COM usi=
ng Linux-cip-ci pipeline please let us know.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN=
-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN=
-US">I=1B$B!G=1B(Bve kicked off various pipelines to test these changes. Li=
nks can be found in [1].<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN=
-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN=
-US">[0]
<a href=3D"https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-=
/merge_requests/65">
https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-/merge_requ=
ests/65</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN=
-US">[1]
<a href=3D"https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-=
/merge_requests/65#note_2298307207">
https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-/merge_requ=
ests/65#note_2298307207</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN=
-US"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-size:11.0pt;font-=
family:&quot;Aptos&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-G=
B">Kind regards, Chris<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN=
-US"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span lang=3D"EN-=
US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar@toshiba-tsip.=
com</a> &lt;<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar@t=
oshiba-tsip.com</a>&gt;
<br>
<b>Sent:</b> 20 December 2024 16:56<br>
<b>To:</b> Chris Paterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com=
">Chris.Paterson2@renesas.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hay=
ashi@toshiba.co.jp</a>;
<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.cip-project.=
org</a>;
<a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujoda@toshiba-tsi=
p.com</a><br>
<b>Subject:</b> RE: ltp (syscall) failed test in CIP Security image with is=
ar-cip-core v1.6 on M-COM<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:EN-US">Hi Chris,<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:EN-US">Please reply to this ema=
il as by mistake Ashrit included SWG.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:EN-US">Regards,<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:EN-US">Dinesh Kumar<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span>=
</p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span lang=3D"EN-=
US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"> =
ashrith sai(</span><span lang=3D"JA" style=3D"font-size:11.0pt">=1B$B#T#S#I=
#P=1B(B</span><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-family:&q=
uot;Calibri&quot;,sans-serif">)
 &lt;<a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujoda@toshib=
a-tsip.com</a>&gt;
<br>
<b>Sent:</b> Friday, December 20, 2024 7:43 PM<br>
<b>To:</b> Chris Paterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com=
">Chris.Paterson2@renesas.com</a>&gt;;
<a href=3D"mailto:cip-members@lists.cip-project.org">cip-members@lists.cip-=
project.org</a><br>
<b>Cc:</b> hayashi kazuhiro(</span><span lang=3D"JA" style=3D"font-size:11.=
0pt">=1B$BNS=1B(B</span><span lang=3D"JA" style=3D"font-size:11.0pt;font-fa=
mily:&quot;Calibri&quot;,sans-serif">
</span><span lang=3D"JA" style=3D"font-size:11.0pt">=1B$BOB9(=1B(B</span><s=
pan lang=3D"JA" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif">
</span><span lang=3D"JA" style=3D"font-size:11.0pt">=1B$B#D#M#E=1B(B</span>=
<span lang=3D"EN-US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&qu=
ot;,sans-serif"> =1B$B!{=1B(B</span><span lang=3D"JA" style=3D"font-size:11=
.0pt">=1B$B#D#I#G=1B(B</span><span lang=3D"EN-US" style=3D"font-size:11.0pt=
;font-family:&quot;Calibri&quot;,sans-serif">=1B$B""=1B(B</span><span lang=
=3D"JA" style=3D"font-size:11.0pt">=1B$B#M#P#S=1B(B</span><span lang=3D"EN-=
US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">=
=1B$B!{=1B(B</span><span lang=3D"JA" style=3D"font-size:11.0pt">=1B$B#M#P#4=
=1B(B</span><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-family:&quo=
t;Calibri&quot;,sans-serif">)
 &lt;<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@t=
oshiba.co.jp</a>&gt;; dinesh kumar(</span><span lang=3D"JA" style=3D"font-s=
ize:11.0pt">=1B$B#T#S#I#P=1B(B</span><span lang=3D"EN-US" style=3D"font-siz=
e:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"> TMIEC ODG Porting)
 &lt;<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar@toshiba-=
tsip.com</a>&gt;;
<a href=3D"mailto:cip-security@lists.cip-project.org">cip-security@lists.ci=
p-project.org</a>;
<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.cip-project.=
org</a><br>
<b>Subject:</b> ltp (syscall) failed test in CIP Security image with isar-c=
ip-core v1.6 on M-COM<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">Hello Chris,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">Hope you are doing great.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-famil=
y:&quot;Aptos&quot;,sans-serif;color:black">SWG locally executed LTP tests =
on M-COM x86 device booted with CIP security image. The kernel used in this=
 image is built with
<a href=3D"https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/bl=
ob/master/6.1.y-cip/x86/cip_merged_defconfig?ref_type=3Dheads" title=3D"htt=
ps://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/blob/master/6.1.=
y-cip/x86/cip_merged_defconfig?ref_type=3Dheads">
cip x86 merged defconfig</a>. After generating the results, we found some f=
ailed tests in the
<b>syscalls </b>suite.&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-famil=
y:&quot;Aptos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-famil=
y:&quot;Aptos&quot;,sans-serif;color:black">We wanted to compare them with =
kernel test results in LAVA and noticed that
<a href=3D"https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/bl=
ob/master/6.1.y-cip/x86/cip_merged_defconfig?ref_type=3Dheads" title=3D"htt=
ps://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/blob/master/6.1.=
y-cip/x86/cip_merged_defconfig?ref_type=3Dheads">
cip x86 merged&nbsp; defconfig</a>&nbsp;is not being used to run LTP tests =
on x86 targets. Can you please look into that ?<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-famil=
y:&quot;Aptos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-famil=
y:&quot;Aptos&quot;,sans-serif;color:black">I am attaching a document with =
the results summary of LTP tests when run on M-COM x86 device with v1.6 sec=
urity image<b>.</b>&nbsp;Please have a look&nbsp;at it. I
 am also attaching the failed test cases in syscalls suite.<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-famil=
y:&quot;Aptos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-famil=
y:&quot;Aptos&quot;,sans-serif;color:black">We need opinion from members if=
 we need to hold back from sharing the v1.6 x86 generic isar-cip-core evalu=
ation to BV members in case those LTP test failures
 are effective.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-famil=
y:&quot;Aptos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-famil=
y:&quot;Aptos&quot;,sans-serif;color:black">Thanks and regards,<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-famil=
y:&quot;Aptos&quot;,sans-serif;color:black">Sai Ashrith<o:p></o:p></span></=
p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_OSZPR01MB85158D80663768F0ECD9D96CBF1B2OSZPR01MB8515jpnp_--


