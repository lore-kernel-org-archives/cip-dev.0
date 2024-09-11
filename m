Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1435EE021C
	for <webhook@archiver.kernel.org>; Wed, 11 Sep 2024 08:57:52 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.86])
 by mx.groups.io with SMTP id smtpd.web10.16703.1726040933020043684
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Sep 2024 00:48:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dfEC7oql;
 spf=pass (domain: siemens.com, ip: 40.107.21.86, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NAozdesmugfa6bHBuFl8pa1lbXXlnt8U7sQS+vN/VuV+mHTdWPPXddgqun1XjFTAbwRP4D63Tg8IuFFdks5Oz1AD/QNTkTtSgQpmRsQeAcjFmFcDUvQ/VEptVgp6c1rRvXGhl5Wed/s5pHrPpcOicyCz/Q0yfAHNzPR20DaNuIvIWZ/dyjmDQ9PRkm1JMnEqxFWS8z3sEe6ptqRlljoJXf0PZbBK94bD0RO4DtdABmTqmlUbZL4IGpbx/aXWZ0OZYS6hqZVmoM24dYNgrNsZvEC25vGKnci3HgFgShkCKVqc0csrUhkTywQxX234ts8y8g2aXInOjgC0BzXTrEMmkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhEqBlVpgXdCCT+iQGPUpRNBylX7bVty/tpA5m67ctI=;
 b=ImEXt5X0IZfzd3xarMTpooH6C8OqSdt0Q3MLBRU88UiGI5UKQS/nxjFIAo5k3hTMWTE87gC79WwRCoGZidcLyDfMYJyU3xQRWOpNXuT+rqtisG84jSJFNPjjVglTgSqXxy1ZI9AHp6ZCEZYrt3hNQ4R7aXSEBhk2yVfem1FNIEp8DLWf4edQ8rtZWA02Q2WGwCnT93e9S5sa3cwkM1xFubHXl1ReUEtBoT3r8XXJDaEOIvt6a5ycUuby5SaKHvkzut/GGw05Ohe4JGXVGW0jYe3JJUdJN/hWNv2sdFwnMI2A981Q0i/WdHJRpI5OxUBvPVcEM7GiqXL/VSe8dpL8fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhEqBlVpgXdCCT+iQGPUpRNBylX7bVty/tpA5m67ctI=;
 b=dfEC7oqlOu3DQ4DcAhpjRug56guIIzOJVHzAaJhiY3IElb5CXpYlPmYJC/jI7T01xktyIARyj2L04eDj9kasMi6kkwrWQx9k5l6vVCrb7YAZ37iU9e3hBWT5Xmag9eiWs3Snn3zSno0Q2I11nQvBB5lyPquqd7XGuCMyGbXGTrEmUqn4oW42QonBNkFnGLRE1gTHT4086MZCXQ9Fi4C+9RXYL2+lf59a71t366yMOs4/GvhZ6msyrZWsje+zuEjLFLnSqKWXj1bIINmWe0XvFpmROyalIlDr/lCb1VtfGWU3CY7bGpqA4+eCl8+1SZAL1KuuVUMbj4unNIyWm19qQQ==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by AS4PR10MB7965.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4fc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Wed, 11 Sep
 2024 07:48:46 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%4]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 07:48:45 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [cip-dev][isar-cip-core][RFC 2/3] Add check for sign-swu executable
Thread-Topic: [cip-dev][isar-cip-core][RFC 2/3] Add check for sign-swu
 executable
Thread-Index: AQHbBB8HH7SgvlUu60ixlXXPxI6N1Q==
Date: Wed, 11 Sep 2024 07:48:45 +0000
Message-ID: <6f9b384306b1172818cb478eac41c15ad25cd2e1.camel@siemens.com>
References: <20240909112309.1028531-1-Quirin.Gylstorff@siemens.com>
	 <20240909112309.1028531-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240909112309.1028531-3-Quirin.Gylstorff@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|AS4PR10MB7965:EE_
x-ms-office365-filtering-correlation-id: 4ffe7cf8-f122-49e1-541e-08dcd2362a26
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?SDdhaDJpcE1QYm02TTFMemJTNGZuazZOQndzVytReTM3ZXkxMDhzME9yYmE0?=
 =?utf-8?B?eWJsb1J5aTRTNkw0S0NBd1ltMStEOUpXVXgyZGhyRkpZaDRaTjBzbkt6b0Nt?=
 =?utf-8?B?TmlCempENStGN2FLdG9vYWMybjlBaDJjdjZMUTR4MjI2SjNUbGM4dmJCZ2cv?=
 =?utf-8?B?am10bi9EcVJJemg4bU1aWC9obVhwZzc2aDlmL1ZoTG5sS2Q2K01lYUhka213?=
 =?utf-8?B?dENkUEVQREFRRFRXRGlMdUdBT3pnZDJFNTdGZHRER3ZwQjBLVVBDTWhuTEpD?=
 =?utf-8?B?YVdFOGpqQ3Ftait6Uk5sZHVqcXBWRnU2VGpaT01LeTAzNEg0QlA3MFY2M3lZ?=
 =?utf-8?B?dkN4WC9KMTdxdDc3NWw0ZlpneXdORzRsb2k2R1FubnBXQWhEcGxnTWZrQlZS?=
 =?utf-8?B?RGdwRGEvMjVuOXFJVmpjOGV1ZllaZ29IWnVxQ1F4RlI5ekJyZzZMT3IwLzEw?=
 =?utf-8?B?VG5aeHg5SndXU2I4VE5wVGx2bzEwV1dzSGp4YmFKcDR2UkMzWGlqazczVEdQ?=
 =?utf-8?B?TzBXQUJHa2o5WnZlYXRMUHI1V29WZVh2TzIzUXV0bVF1UU5YK05ZeWxtdUM0?=
 =?utf-8?B?K3UvbEZrYVpJckNLdUkwOXU1bWdsQTRRWUpJMTFDSGtvOXZJbzBWSXdjdnBP?=
 =?utf-8?B?bVhzc1QwOGxjNG5xWFcrNXJyR3VEbm5WVS9FWEE0bUQ2Z2EzYWs5QUdIN1Bo?=
 =?utf-8?B?QjhCWDY4OUtzTWpTYjFZWXQvQlZiVXRkOHBFTWJxVzNWMXNBazloRnhrVjk4?=
 =?utf-8?B?Q1ZFREpoNU1rUllpb0RTajdsL0k1bURnc1pTRHdGWkVoZlltdVB5RWF6a21M?=
 =?utf-8?B?UTFVTUoxWDBKb3laWlNLQjZNNlNSRFJML1NRTTVKdG5FeExOb0NHTEJaN20z?=
 =?utf-8?B?VU5Tb1JITzZ4MjZDbXppSEVvNlcySzI5UVF6aUZFbE93eTVRc1pkeVozQkFs?=
 =?utf-8?B?TmJ5NFlzbEpyVjh1Zm1RcXE3SnU3TGRzOW4xRFRWRTJGMnhmbS85c1MyeS9m?=
 =?utf-8?B?MnAyd081UGhwbG9MaFdablVDU3B2T09rM2Nic0NyMEZOMC9teitJYWZ1Ri9U?=
 =?utf-8?B?c3N0YmtHQnFXb3FSVWhNVmgxRTZDMVJnT3hVWDVJcXJUUzVCT25vUFMyTWx4?=
 =?utf-8?B?ak5ZaGtjT0xVdjJxYndKTnZvVTRvMlZpMkJPcU5YMmlZaXBlei9jeXJQa29T?=
 =?utf-8?B?NzVsZERUY2huRHRzSHQ2RjdlVkx6R1FlNjcwZVhsTWFwRUxqQzlpQXE5LzFy?=
 =?utf-8?B?cDV4ZGhwYm8rZVcxZG50L0dXcnpIa2ZTa0xyU1VTcUxlSkowekpwTkRJc2VQ?=
 =?utf-8?B?VTFmK2dZY1pVanNEbEZoTTQxMkFpTDg1Tll2MmZ3aEpvdmsyL3VjTmUvbHc3?=
 =?utf-8?B?VHJOb2ltNWlOMnI3Q0sxWjA1TWRoOUQ3dVN4VjE1RllwL0J6QkxsRE9PQUxK?=
 =?utf-8?B?TmpTMkFoalFQZkc3SWlGcGV2NlVCQkhNbjRhZHRkUkp5YkNWTGM3bjZ1M0lZ?=
 =?utf-8?B?SUtWQjFGUmtnc3c0Q2N1ZHNhNmxiNVVETUsxVEgzTWYrMFIyc0lVQTZqMENK?=
 =?utf-8?B?TWVuaXlEZHhmaTZKT1Bpa0M2eHR6dGI2NVBhV1FSS0FTQ2hZTzIxMllCRCtu?=
 =?utf-8?B?SWZFNnRHS2ZjZEJxZENmcERZWWI0d2YwSXIxczgvZ0lZZDV6QUZybTJaS3JL?=
 =?utf-8?B?R3dJNGlKMHRkamlLSTExaVBHZ2VIQWF4cGlhVzlnNm1zUWN2dUlwa1JGUzBu?=
 =?utf-8?B?NklaeENLVEQ1OExXb0R0SlBoTHl6Wmhlc3dJbWlxYWhxazVxUFJDYWI1ZHNl?=
 =?utf-8?B?RUNVL2lCbTdhYlhVMXJGS3FjOFR2RDQyOHhxTkhiV3FiZnJXc2lpQms3UFE5?=
 =?utf-8?B?eHdKbXNFNHVrcXlXOEJWc0dIRkh4QmdmSTVIS3I2WW1BZmc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TVFzaFpHSkdWY0J5TmpNR2dYbGU1QlAvT290QkdsTUZCdysvZlRtUVY0cGtF?=
 =?utf-8?B?a2hBck1FY1MycFdYRUxrSnhNZUxNNG92RXI4Zk5STDJkNTlMbHlFUGlKMkd1?=
 =?utf-8?B?dHRSUjhhOWVsYjN5cXp3REpDNzBJWXY3T1JXL08xY0N2TTZIcnVFMXhKcS9r?=
 =?utf-8?B?WDMwWS9ZeDJwdnJVdGRDcG9ZYTdTZ1l5V3JXemFyYkNrQ0pmWFpwSXdsNTIz?=
 =?utf-8?B?V053ZG5jQzAwT1YvUWxNVU1xTHUrZW5XNzBkb3ZSMmNaVTU1cFUxVlMwVENm?=
 =?utf-8?B?dG1BbXhkWFc1UEowcnVpRGc3ZFovYmVrS083Q3J2emFmaldiVlRqbnlXUi9C?=
 =?utf-8?B?cTZWdjdNejIveldiTVpFZ0h6OWxDSGZObW9rZVFCaGdMaGIzaEhHcXdjZGFD?=
 =?utf-8?B?Q1VXcmFmbXl1YVZNRzJjZmxWSmhqOHNheWk5S2N2blVUcVM4N1dGOG5wL1ZF?=
 =?utf-8?B?UWtmcEhRUkhXM2owRDZLbE5UbExiK2gzbUZOZk5MZElXT1h4N0tPMVpvMDdM?=
 =?utf-8?B?VGY0OGY5eWtuakM2eURuWjQvcmxnKzU3VHJLZHRYOU5LSkNhc3J4eW43Z09I?=
 =?utf-8?B?YnpRek9SK1BSazIrZTVMSjRDUkZaM2dlUTJkd0RZTG1HR1NHYWR2ZDNKc21H?=
 =?utf-8?B?ZDFWRGE1NzRraXVTNFpPMzkzSjV0cmVESDFPV3FuRXppK0xES21YTG1FZ0Jt?=
 =?utf-8?B?VHhhTXlaNm5JV0J3SDZrVnNpVGRxVzNkdWpBd05Ib1pXYWlnWmc2ZWF1dXE1?=
 =?utf-8?B?NzczUEJRQjF4MTRXRFZ4dVM2Yy9RWFQ2cmdDMGVvMHNwMFNXUnZicmQ0V3dN?=
 =?utf-8?B?MkowVU84SXZ3RVJ6dFA5TU45Z3oyS1RjanBmOUY1WlBrRHc2V3p2MWRVRGFI?=
 =?utf-8?B?MDdKM2t4aUxORWpoZWF4TGtzUnhSS1ZQOGVpZkljUytPUUNJYWM5bmFHOXFU?=
 =?utf-8?B?NVl1QUtLNGFxR0VSY3BNc05YdmpqSFZmdFJoaE5hWTI1bXhIQkJ5OGlia21p?=
 =?utf-8?B?RENUb01jMjZqT0Z3MmZEV1hWTVJTcDJCYmZZM01JbDNhdGN6OEY5RWh1NzNU?=
 =?utf-8?B?bUM0MFpmZ1RWaW1DNnpjSXg5dFlyRTFYWTJDYjlDOWJEbG9ES2xsNHdrVnNQ?=
 =?utf-8?B?bGNFendVcWlLeDhRK2FwWFpuU3N6bmFIOGxYc3NGd1VQSjBvcE1nMEgxS0JP?=
 =?utf-8?B?WTM2Qi9GSjE3MXVjZnZUYzRGL0NqR2dtVFF6M3NDdVpiM3d1ZjUwSnBDcnZS?=
 =?utf-8?B?VDRERFVuM2tXY0FmdGlFSCtsNDIvVE82ZnNtcVhmVTFWWFcyWHZacG1uUXRh?=
 =?utf-8?B?cUU5TUpQbzZNakR4ZmNNV1dzSlo0Z3hpVmgyckZUd1hXYWhwNFZnYys5dzFN?=
 =?utf-8?B?S2NDSXdSTEljcWJIeXJFTG1RRmMzeHBIR1ZuM2puWUNOWlZXNmV5ZWVpUXU3?=
 =?utf-8?B?RE9hWFo1TW1JdEcvbkxwWks4U2djZHFaNnlLUjE3ckNhVThFcFp2cFdPSFNm?=
 =?utf-8?B?WXZISDZkL2RvUGYzZm90NHZPNmJ0M0hSc2dvRlE4bXYwdmFnNVlIQ1F3U3FJ?=
 =?utf-8?B?cjhtbC9tOFNqUlpOZS9UVmNVSVc1Zk5Sc0VUcTRldFRXVmxKVDhqeXhUUEx1?=
 =?utf-8?B?MG9MWHJvczk4N3Z2RG5sOEFreHZRd2x3L0pheWwxMVRSem1WMEtsUldFT1Y1?=
 =?utf-8?B?QkVSeHphSERzYmJNL2MrOCtrYUltZ203VDlzeXhCZmxnZjZpVGQ0enFUK1BU?=
 =?utf-8?B?WUpWbFh2R1BtSjh1dDNZNUNpNDZ6QjdTV2U1OEVGNWhtdVQwUWM4S3BYSUU5?=
 =?utf-8?B?cHhKTnBqRVpRTkVNcDF1NU9LR1BLc2lCa2NudXRXR0F4cmhPeE9WRDE2ekNq?=
 =?utf-8?B?OUVUTCtZOGQ4VmlydmxtQVFLb29zTmlhVlhBRHJqVUhPTHc1dkhNVmgzQUk0?=
 =?utf-8?B?RXhOREFXc2Vmd3RPSnE5MjljbFpJZjdHOTNaVk5CL1BDM2dIbWhXcHdWYUVX?=
 =?utf-8?B?MlFYWDczTUh0S2U0QjUxSE51WWFNOVpFeWg2SDBIOE0xNHN2WkMrbTNwaUtJ?=
 =?utf-8?B?RUZvZ2lWMExRTkNOY0kzNFpqamZuaHd2WlVUbUZFbGlmOGZIZmJRUlRRRkxC?=
 =?utf-8?B?QkJIcUN2VE0wWEpraHd0d3llcVJtNVFzeDhNcXVhU3d0WlV4UDEzaDlLcmIr?=
 =?utf-8?B?blZOY3hBdGkrTWxFb2c3VUgyaXd1YVQ1R3VnaFRORTBKOUZQaCt2QVFnNDdR?=
 =?utf-8?Q?ceauujzbXUsDlyFdPGUAD5tUGrwsU5m8wRqzgckUoY=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ffe7cf8-f122-49e1-541e-08dcd2362a26
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 07:48:45.6600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5F8vKpItCL/2R2StvNBYVjppL1fpw8kMDA02wkoFI3+5AZcAsZnptMOXzBGpzmDXkWIEg1pfa0NjGgth+X5RPHurlSh9DZOAhXKi2lgbRKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB7965
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <03E6B39948DDF742853E4FD198F86C6B@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Sep 2024 08:57:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16882

T24gTW9uLCAyMDI0LTA5LTA5IGF0IDEzOjIxICswMjAwLCBRdWlyaW4gR3lsc3RvcmZmIHdyb3Rl
Ogo+IEZyb206IFF1aXJpbiBHeWxzdG9yZmYgPHF1aXJpbi5neWxzdG9yZmZAc2llbWVucy5jb20+
Cj4gCj4gVGhpcyBlcyBlbnN1cmUgYSBjbGVhciBlcnJvciBtZXNzYWdlIGluIGNhc2Ugb2YgbWlz
c2luZyBwYWNrYWdlcy4KClBsZWFzZSBjaGVjayB0aGUgY29tbWl0IG1lc3NhZ2UgOykKQW5kIHBs
ZWFzZSBDQyBtZSBpbiB0aGUgdjIgb2YgdGhpcyBzZXJpZXMuCgpGZWxpeAoKPiAKPiBTaWduZWQt
b2ZmLWJ5OiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29tPgo+
IC0tLQo+IMKgY2xhc3Nlcy9zd3VwZGF0ZS5iYmNsYXNzIHwgNCArKysrCj4gwqAxIGZpbGUgY2hh
bmdlZCwgNCBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2NsYXNzZXMvc3d1cGRhdGUu
YmJjbGFzcyBiL2NsYXNzZXMvc3d1cGRhdGUuYmJjbGFzcwo+IGluZGV4IDA2NDE4ZTUuLmYxYWYx
ZmYgMTAwNjQ0Cj4gLS0tIGEvY2xhc3Nlcy9zd3VwZGF0ZS5iYmNsYXNzCj4gKysrIGIvY2xhc3Nl
cy9zd3VwZGF0ZS5iYmNsYXNzCj4gQEAgLTIzMyw2ICsyMzMsMTAgQEAgSU1BR0VfQ01EOnN3dSgp
IHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY3Bpb19maWxlcz0iJHtTV1VfREVTQ1JJUFRJ
T05fRklMRX0iCj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgWyAtbiAiJHNpZ24i
IF07IHRoZW4KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIFsgLXggL3Vzci9i
aW4vc2lnbi1zd3UgXTsgdGhlbgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBlY2hvICJDb3VsZCBub3QgZmluZCB0aGUgZXhlY3V0YWJsZQo+ICcvdXNyL2Jpbi9zaWdu
LXN3dSciIDE+JjIKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZXhp
dCAxCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmaQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgCj4gc2lnbmF0dXJlX2ZpbGU9IiR7U1dVX0RFU0NSSVBUSU9OX0ZJ
TEV9LiR7U1dVX1NJR05BVFVSRV9FWFR9Igo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGlmICEgL3Vzci9iaW4vc2lnbi1zd3UgIiR7U1dVX0RFU0NSSVBUSU9OX0ZJTEV9Igo+ICIk
c2lnbmF0dXJlX2ZpbGUiID4gL2Rldi9udWxsIDI+JjEgfHwgXAo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBbICEgLWYgIiRzaWduYXR1cmVfZmlsZSIg
XTsgdGhlbgoKLS0gClNpZW1lbnMgQUcsIFRlY2hub2xvZ3kKTGludXggRXhwZXJ0IENlbnRlcgoK
Cg==

