Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.13])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.783.1795709293934031750
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 08:08:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=YmRfIgSD;
 spf=pass (domain: siemens.com, ip: 40.107.159.13, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LYbtF2b3RR6LtpqVWmS3GjvKHHW+KirVVI28qFRwh4MwU1WyxSv4+aHetLNjzwcbsUxBN93iLF96dgO42Cpqwfz1YgQoyEf7fY2Ol2HO8AEOb998rX6+7DWqdnlrAc4HF8S/YFAxoUxAZ8enZ0gPhnoJtKNElw1IaTehTIZgHniBt66HhRhkYjPKuChtHGq5BH8iKZ5hkUpxzH/z4rrBoQgLtZ97FP4Osnl6cLTTrps8qpuZX51iMXx9ukKJyFZXZPi0LQKdFEnIpEPfHB55B3FN0+BLQdVSIJWmebBjyX4HuuZP4MFaZ9Qqt3vh8oGc3LCNFtTM22Eqkv4NVmNA2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hptjKgHjsZ4JbYR3P31xWgfYVzeY5Dkl3ewZGY/ftBk=;
 b=O2mpOLi8cgBdbuck0FvURSTGg01vTXZLP1lBM/1WWKs+6xwVwBBfXfMiTLp2VRz8taZCmcHwM/wwEFRndfO1U1H/ASWerWV6cB2K4rhy7jTwpTmHFb7zGVvAEjWXyGBTY+87GhZ3qqGj+JH8QcaPby6JLIx86GC3HdPwwZcGBXQ1DxaD7Hlmp32nVv1mLBqrMfL0WT8P3A3mAXNzjRYL09HNlCI4nNtJ36VFoKbFZ238R1oYgDNKJuYBtguGT8Sc+9QUzhWAdCvq+ZEQN87QSJJF6gj8WdDhiQERvyJTJgfnpJFe+CURCyfFXlBNlu/S5Tv+Qn3Nfpv+IbHaalUHKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hptjKgHjsZ4JbYR3P31xWgfYVzeY5Dkl3ewZGY/ftBk=;
 b=YmRfIgSDlbE7ju5/y1ExE+W1NbZfjaZbX+go/4ljFXzISNptUM63X6jhzQC17TPg0/Hy0f9isNNeGhmzaGaq5Th2b/pIHx3ZSRSO/CGHl3rD5dPZM1lXuhikWXQGc6NM9eDJrgWkBwZGSutQ0OIrEBAJYZL/fWdw/ELPUHhatl8pjUuq0L/08SxQ6AR/AkHXgL0MldgO0iTkoMiLrWi41ZDZKL6PZ2E+W8NqKoTfU1zbNv4a5LdKxOkrvxMeABwqAZS3vFaM+t4anWNTplIbOIwDX4hutGl9sM/86hSsJAg68m/K7hKMyZ6OkwlBtNDyl2NYEsgnOqP/iqP59PrFcg==
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by MA9PR10MB002947.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:250:101::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Thu, 26 Nov
 2026 16:08:09 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%3]) with mapi id 15.21.0662.001; Thu, 26 Nov 2026
 16:08:08 +0000
From: "Moessbauer, Felix" <felix.moessbauer@siemens.com>
To: "Prusty, Badrikesh" <badrikesh.prusty@siemens.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: Re: [cip-dev] [isar-cip-core][RFC][PATCH] swupdate: deploy
 SWU_ROOTFS_TYPE artifact alongside swu
Thread-Topic: [cip-dev] [isar-cip-core][RFC][PATCH] swupdate: deploy
 SWU_ROOTFS_TYPE artifact alongside swu
Thread-Index: AQHdfal4B790cnQxkEWwXIaZs7A2mbdAhVQA
Date: Thu, 26 Nov 2026 16:08:08 +0000
Message-ID: <f2b2d5c13790a1ebad1ad21c72ecb0f236b5e180.camel@siemens.com>
References: <20261126132340.121225-1-badrikesh.prusty@siemens.com>
In-Reply-To: <20261126132340.121225-1-badrikesh.prusty@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1-4 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3956:EE_|MA9PR10MB002947:EE_
x-ms-office365-filtering-correlation-id: 5ec79251-e89b-40d9-55a8-08df4bd77677
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|55112099003|56012099006|11063799006|261102123227099003|261022115727099003|261022105027099003|261021123027099003|261021121427099003|261009223027099003|261026140227099003|261022075727099003|261028144727099003|38070700021|10067099003;
x-microsoft-antispam-message-info: gisFI0zUIV7OMI5tCQjYjOzT7KP3Wj6vS+cEcZjmblAYJZFKVa8FCvQOttJ7bnCpsOVVhsDh6I8sBXHdy/Z4T+WCMZ2YgCpcBk8ZtWdLJjQiiB3s8/3iuzwYAcSA+pMkPDTv/nkYBkU7LBTPnHF4y/Whr8EqdDlGrZ0LlckVexsLDPH9Xwmy1z1KXQNho0pd003y7QMNmkAllgqn8OCuK/J5rvSBPOQ/HIjCwvF6+gRtddZdm6QsRhmrrsOwAuER5pkEWUbuWqOy7CYeA9/19NLYluVm2TNezTqC4D9QhdOnPtq0tZdCML/ZpCEL8FdWFJhxyKS99GhkHRciLVWFSn3Vk0dbdFGWrfkp/tKeDoWWRXPRtx3eqWwRmNlM1HuhqWLF3pT12fYzD/67+Ze79KjLJnFmiz5NqkA9J0gnobrhJkx0d58TQC1Rmq8q+8mLJUg50VoaMcANVGBTGfWI+Q8VXmD0yBeShCIi5nfbBB0VkjGtCgmLqbD5FXfuqLPgHGckbM3JfeunqHvn1E8iWWJSBU0bRAtL9xNQjbHrG2gbvNUpIPtt3KAq4cx1IDNRlQJ2c+7S56gByLwgfNZyZ9wzHQ3qqcqGSWxNxCxtrm6QiXlZABSryYDTi5QVVsjCLN9i6ds9vkRSfGWw7AUsfDGxSpOtfMS5xflPuBtnApmooowCyhXJ+YDkJ002bWPpq9M4HwMfKRA8XrCiA9vdoiCSqjx1fg6ObFk9loW9fu8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(55112099003)(56012099006)(11063799006)(261102123227099003)(261022115727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003)(261026140227099003)(261022075727099003)(261028144727099003)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmJQalBBK256YXhRbnAvVUFMYnU3MHZlT3lVaDR4MG55QnFScllKdjRWZGoz?=
 =?utf-8?B?MWVCTTR1K1hGcXN2SkRVM3o2RzVINzd2cHBuYXFUMnNHTWlOc3FCazI5bU1V?=
 =?utf-8?B?eXhTL0VqY3IrSzlQVC9SVWtoU05udC9ub3JackdCank2OWc4NjNMejRnMEFV?=
 =?utf-8?B?K3VucFNrVzg3UTdIQlRwZk1Gb3BrSEVXQk9KdWE3SlpxZVVIY1d6bHdyRC96?=
 =?utf-8?B?dnM1UFBScEM0TFUxQkRybXNzVERaM1gxbG16OEFkdkZ1V01MM1J2eXowZXZU?=
 =?utf-8?B?Q3d0cHQyaERxSURYZVErYTdjSm50S2pSN1VqQTAvU1F3cHdwQkV4V01TTk9k?=
 =?utf-8?B?TUZQN1R5MUJoWXMzOTlJOGhnTllxbXdjemVDdGVOS3Vsam9vT1JmaTJZb2kz?=
 =?utf-8?B?QWhrVER4WE5NamliaTdrZGcxWVFIc1JOalR6clJQY0lBQlQ0REljZUN1U3c5?=
 =?utf-8?B?VkhtTHF4ejJXM25RaENlZDBNSWg0RUxBcG1nazZ5T0UyVFdGdlZ6THVZVk5J?=
 =?utf-8?B?d1VTYTZVU0lRc3Z5VWN0WVlmY1ZIb3A3enJNQkw4bURCL2l1SVR6aDJQN1lu?=
 =?utf-8?B?d2pHYk1mZFIzOFg0SmtiM28yS2tDRndWWFV1eTdvclEyL3oxRERoRkw0NDNr?=
 =?utf-8?B?YVkzblV2cnczaXYxQzBYUnFmSWVWZFZiVnp0dHpXcmhqdkErVXk3Z0lORzZY?=
 =?utf-8?B?OWhpUnBvSTBPY3dNREFrbUtTMk5lMWFLTUM5N3I4c2MzTmhNQ3ZZZDFqRWtF?=
 =?utf-8?B?ekd6VGdJbGNBc1lzQ25wdGhLWncwZ0hWUjhNR3VESFJmZWJFSzdzcURLemhS?=
 =?utf-8?B?WFNJQVRWTjltc1llUnV5VDNsR1VYaysrdjhyR1pBK05NRWd6czNTSDZQOWlu?=
 =?utf-8?B?NnRtSGRDb3d6N01QNjZlanAzOHdjUGUvVlNiSDNhWEZUdWJCdkpxbmFVU0Iz?=
 =?utf-8?B?alYvSjd3TkcxRVlGTVVVZ0ZEcUladytvQytXakpTdHZqUk00U3RndFRCbVI5?=
 =?utf-8?B?NWRtM2ppNWNqZVRySElscUw4emJYZzRmem9HMlg3Lzh1Vk4vcWw2MFp5Vmxl?=
 =?utf-8?B?UGxzb0pwSi9QZjVSSFE1VXVPNGpuTHRPcVpLdnVjS1o4L3I1ZkZ0dU5Jc05r?=
 =?utf-8?B?cWYrUUZERFNwYkU0TWZ5QkpKamFuS1Z2UzlpMjZVVDVlNmE0TXhaaVBIczJY?=
 =?utf-8?B?a1k1ZHV4ZTJzNDNVQW5IOVRUOHNGU2hyZnYxSWRROEMrWmwvWjF5alBYL0x6?=
 =?utf-8?B?emdZU1UyV3pHeFBDL3Y0UmNzbzQzdndJb1J0VHZFWGdBYjY3enN1MFptd0Nu?=
 =?utf-8?B?aURoUjZZT2cxTmNPVmFkRm4wdTVuRFZRRi9sY1ZzZXd5ZjZCNi9KNG5WdWpm?=
 =?utf-8?B?SDI4aDV6N3JDcWtnVSs2V1k4TFdwa3JnU0lHSm5pZnlPcE1HZ0NpVDRJSkZP?=
 =?utf-8?B?bndvTmNPV0tiODcvTDlhcHB0eGRmVXdyY0U2M1NKQ3BkNnJoRUV1SWtPUFlB?=
 =?utf-8?B?R2dBVEswYUcvNDhsbU9HRHRzSGFnRUxrVVRORnR1eWVTMG9rWk9UMXlialZo?=
 =?utf-8?B?ZGRJMVZudUNqdmlReWlNVzRkUGxNRjcyZUNmMjNmajJDRzJNVTViOVFsWWdr?=
 =?utf-8?B?Sm15eGJxZmR5TnFBZFh5NEJQa1FaQ1dVODVyakxJYW5EMFBObWd5YW5EMG41?=
 =?utf-8?B?TFZWVWNOMTR4Rzljc2Vnc1NtTjFwTEw1Wm9YcGpJclRtMXV6TWZKcm5GSFBt?=
 =?utf-8?B?MTE1Q3k1QXZsYWNaWXlRVEFJb3lhbWg3eWpFWXBFL3prRERuS3QxMzRrNkow?=
 =?utf-8?B?aU44RHBuWFJJczlqbnFsUmdhZTF0OS9jZUlEVnpLLzBlZU1pK0JkdkhYZzd5?=
 =?utf-8?B?dm0zL3ZZdDhERWdZQUp1R3JVV2tqeU1XcVRQME9qeGxGUEFpOG45R2t3aVVV?=
 =?utf-8?B?ald2dldLaFdQbXJvYzl0cXNLc2ZyeXk1cDNwaWxDcjlUc1hXcTFRNXk5S2xM?=
 =?utf-8?B?di8wVm1qYzI2LzF3eVVBbU8vV05HbnhsSEhlbG56SVFuN0ZKVytPT3RETUw5?=
 =?utf-8?B?TjhVeTlmMDJMWERtcUthamxuVjJaSWFGS2ZETjcxSGErbTNEMUlOZFVpTjBv?=
 =?utf-8?B?YkcwT2FtcHZnRVgvVldjbHROS2NUaFRvNFJ0RG1semxxV0wrM1BoMHB2WEtJ?=
 =?utf-8?B?NDhEc3FramtRbWlqNnN1ZGxiUHN3NHdITUVHamlyVUg2cHlpaWpYblQvQ0ZF?=
 =?utf-8?B?d3hZTzNBTm5JQ1hFVURNVXEyOUE0NHlZTktHQThRZXdPOXU1ZitGamdwTHZN?=
 =?utf-8?B?aWp1VUlhWjhzZlR1WlZOemJWRWdDMEVHc2hGbUJmam5JSmw2d2MxQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2EFEC48CBE163B43A59B210BF090DB7C@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec79251-e89b-40d9-55a8-08df4bd77677
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2026 16:08:08.7108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 52Gp5q0GR/zGrpqAiuqZB+4lKcEABAffaPhQT+KN8Ok7FZLBCVn1L0Dw+6uZftpJCLMSo17qCarXV6Mla46uNFmhOjxu52h8dYdJzfbvFmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA9PR10MB002947
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 16:08:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25224

T24gVGh1LCAyMDI2LTExLTI2IGF0IDA4OjIzIC0wNTAwLCBCYWRyaWtlc2ggUHJ1c3R5IHZpYSBj
aXAtZGV2IHdyb3RlOgo+IEluIHVwc3RyZWFtIElzYXIgY29tbWl0IDYzOTM1MjMyICgiaW1hZ2U6
IHJlbW92ZSB1bnJlcXVlc3RlZAo+IGludGVybWVkaWF0ZSBpbWFnZSB0eXBlcyIpLCBJc2FyIGJl
Z2FuIGNsZWFuaW5nIHVwIGludGVybWVkaWF0ZSBpbWFnZQo+IHR5cGVzIHRoYXQgYXJlIG5vdCBl
eHBsaWNpdGx5IGxpc3RlZCBpbiBJTUFHRV9GU1RZUEVTLgoKVGhpcyBjb21taXQgaGFzIGJlZW4g
cmV2ZXJ0ZWQuIEJ5IHRoYXQsIHRoZSBwYXRjaCBwcm9wb3NlZCBoZXJlIGJlY29tZXMKb2Jzb2xl
dGUuCgpGZWxpeAoKPiAKPiBQcmV2aW91c2x5LCBzd3VwZGF0ZS5pbmMgYWRkZWQgJHtST19ST09U
RlNfVFlQRX0gdG8gSU1BR0VfVFlQRURFUDp3aWMsCj4gYnV0IG9ubHkgYWRkZWQgInN3dSIgdG8g
SU1BR0VfRlNUWVBFUy4gV2l0aCB0aGUgdXBzdHJlYW0gY2hhbmdlLCB0aGUKPiB1bmRlcmx5aW5n
IHJvb3RmcyBhcnRpZmFjdCAoc3VjaCBhcyAuc3F1YXNoZnMsIC52ZXJpdHksIG9yIC5lcm9mcykg
d2FzCj4gdHJlYXRlZCBhcyBhbiB1bnJlcXVlc3RlZCBpbnRlcm1lZGlhdGUgZGVwZW5kZW5jeSBh
bmQgcmVtb3ZlZCBmcm9tCj4gREVQTE9ZX0RJUl9JTUFHRSBvbmNlIHdpYyBhbmQgc3d1cGRhdGUg
Y29tcGxldGVkLgo+IAo+IEhvd2V2ZXIsIGRlbHRhIHVwZGF0ZSBnZW5lcmF0aW9uIChpbiBkZWx0
YS11cGRhdGUuYmJjbGFzcykgZXhwbGljaXRseQo+IGV4cGVjdHMgJHtJTUFHRV9GVUxMTkFNRX0u
JHtTV1VfUk9PVEZTX1RZUEV9IHRvIGJlIHByZXNlbnQgaW4gdGhlIGRlcGxveQo+IGRpcmVjdG9y
eSB0byBjcmVhdGUgYmluYXJ5IGRlbHRhcyBhZ2FpbnN0IHByZXZpb3VzIHJlbGVhc2UgYXJ0aWZh
Y3RzLgo+IEV4cGxpY2l0bHkgYXBwZW5kICR7U1dVX1JPT1RGU19UWVBFfSB0byBJTUFHRV9GU1RZ
UEVTIGluIHN3dXBkYXRlLmluYyBzbwo+IHRoZSBwYXlsb2FkIGZpbGVzeXN0ZW0gYXJ0aWZhY3Qg
aXMgZGVwbG95ZWQgYW5kIHJldGFpbmVkLgo+IAo+IFJlZmVyZW5jZTogaHR0cHM6Ly9naXRodWIu
Y29tL2lsYmVycy9pc2FyL2NvbW1pdC82MzkzNTIzMgo+IFNpZ25lZC1vZmYtYnk6IEJhZHJpa2Vz
aCBQcnVzdHkgPGJhZHJpa2VzaC5wcnVzdHlAc2llbWVucy5jb20+Cj4gLS0tCj4gIHJlY2lwZXMt
Y29yZS9pbWFnZXMvc3d1cGRhdGUuaW5jIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvcmVjaXBlcy1jb3JlL2lt
YWdlcy9zd3VwZGF0ZS5pbmMgYi9yZWNpcGVzLWNvcmUvaW1hZ2VzL3N3dXBkYXRlLmluYwo+IGlu
ZGV4IDY5OWM5NjEuLmJiZWRiZGQgMTAwNjQ0Cj4gLS0tIGEvcmVjaXBlcy1jb3JlL2ltYWdlcy9z
d3VwZGF0ZS5pbmMKPiArKysgYi9yZWNpcGVzLWNvcmUvaW1hZ2VzL3N3dXBkYXRlLmluYwo+IEBA
IC0yMiw3ICsyMiw3IEBAIHB5dGhvbiBfX2Fub255bW91cygpIHsKPiAgaW5jbHVkZSByZWNpcGVz
LWNvcmUvaW1hZ2VzL3N3dXBkYXRlLSR7U1dVUERBVEVfQk9PVExPQURFUn0uaW5jCj4gIAo+ICBJ
TUFHRV9UWVBFREVQOndpYyArPSAiJHtST19ST09URlNfVFlQRX0iCj4gLUlNQUdFX0ZTVFlQRVM6
YXBwZW5kID0gIiBzd3UiCj4gK0lNQUdFX0ZTVFlQRVM6YXBwZW5kID0gIiBzd3UgJHtTV1VfUk9P
VEZTX1RZUEV9Igo+ICAjIGlucHV0IGlzIGFscmVhZHkgY29tcHJlc3NlZAo+ICBTV1VfQ09NUFJF
U1NJT05fVFlQRSA9ICIiCj4gIAo+IC0tIAo+IDIuNDMuMAo=
