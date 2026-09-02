Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3FDC61DFD
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 08:19:55 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7750.1788337185394388589
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2026 01:19:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=J14Li3tY;
 spf=pass (domain: siemens.com, ip: 52.101.84.31, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9oesRIdhqKi2VFgqoKCIZhMjhSZROf1Yz9Wn5zIIbBeYxrecN1D04JMdIFO2hdemxRjAusP3jglFIWKGAuONhNkO3Ner652TNlozCxi1MyjWizG4Ql5KTCE1/Prgm6UzSNFRaA9wy8eEzrkOHVcsmMGajrEr3HfrtY8zdJaJPUZjblds/raeHHecberEnnrh200QlA3xGq69RdGgrfiP1sAYrvIMPHMqR9USFCT5ZHMdyYJRHW+5knyQbkGIQ0InhHh9q5C+Xg6wqBYoGjZZGL1BZXFJAQ0M1LswY8keKsG8emn2+n1mXafu8VDEuem7Oa7AxCxXo+Dg56TVx0F0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PQh/yUtE0eUZi+tSakuUNc6nSWebKvq4zzc5B2qBTs=;
 b=ccrURrv0ufSeqJuRhkTZSKIiv0rMw8lKutP6D20en5WikW++AwUO0Gescg0TWMJvbZApIJp7njBcFalPtCkqhPue4beLEOgPo8uMviWYeZrzZLPM8+hMv97WMjOvi+0V1ROAxQMhMdyIyPfz+Nh0j+G8frRJnCciolfk0yq4Zz0Bi4t71NNMC0X+zhs37VHBVGgA1ljxKEb4IsxAVGqgmIc2hRlm0LkUuh8Dc//D7Y78hmB6E6c7KdimGF/vuu+vfeYYrFMEfYtpc4pkXXPggcufiW7b/H5DY+/6IDuLz+nvfytVQYyVVEGPOz865rauCdfeyazGJRSSmhSt9ACzoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PQh/yUtE0eUZi+tSakuUNc6nSWebKvq4zzc5B2qBTs=;
 b=J14Li3tYks+XT6McY0ksXBeoAI2IuSa/O/OJnIlmTU4ecLvvSI03QuIB87C117Pp1aFuna/SyPwm1KRIWm5Y8J0kKvUcE/M745fcGm2iisbgsK3a2Se77PcdYiSc29q/Oc4Wv+BlIJtc4imRe0G2N4FZ+r7CHYJE4xrlqFqyRzCWrMiSl+2NtJ814muWzGSHYr+8tOhdJ99BSOMk5o73zI6EdClDZlaiDerjw8eoJAO3Jf0gwcSV+C6IrBSn50+rKI/RCXXc0jv2OmRtvDO2Uw+d0Fqz5KClvuPAHZRMawepoxUT1uobHaPJUyZh+BhBnSTJ0N9/YtlkAwep6Rf1SQ==
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by DU0PR10MB7096.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 08:19:38 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 08:19:38 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Kowalsky, Clara" <clara.kowalsky@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "Gylstorff, Quirin" <quirin.gylstorff@siemens.com>,
	"Adithya.Balakumar@toshiba-tsip.com" <Adithya.Balakumar@toshiba-tsip.com>,
	"dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>
Subject: Technical Showcase at ELCE 26 in Prague
Thread-Topic: Technical Showcase at ELCE 26 in Prague
Thread-Index: AQHdOrPL3byzwBA5jkC8W9/stittPg==
Date: Wed, 2 Sep 2026 08:19:38 +0000
Message-ID: <061493623afc73d341909da51c685e87e3fc8fa0.camel@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-10 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3956:EE_|DU0PR10MB7096:EE_
x-ms-office365-filtering-correlation-id: 1437f14c-b637-44d5-560f-08df08caee6e
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|38070700021|10067099003|56012099006|11063799006|6133799003|18002099003|55112099003;
x-microsoft-antispam-message-info: 
 QKyA7i7OrjcqEEr65Q9R5fRs0cz3AxiHwAV//Jie62i3qcUcapAJ9hRy7Lhbs+ZqqELX9k11YZfK4h45im6zwpkpYKRxf5QU3KQwF/96/t6rPgHsumHByT8nWSxDs77AQcEU2jur8Cgz5mDrOc1qgZBShl01fo16tsgtW8VPoKsHdxmsD68EUv1loaQvBpVhNDOx6xFKzeB71et0DAkdjpAv6IzM5sGzC8axMmtbBC9b6fvPMJoeUS3kc47t2pQFrCswH3XFyBl0CAMJnq4WRnAZweexNV7WcjFYmWuXsiQ+8Yi8AJMCJTtwuXF2iobOIshN6xnzSyKXt3MhJ5n93lpnNQZ4+jl4yszOdqv0ywMqtJPR2f4+BFq9cEAFCaqNgH0WNTwBOrJjj2EYT062ncWHnVGDGUOE/UPFQomDiAq8tsdxlJxRN181FDIA4eLG65Glw92uA446lQhWhVhMQaxclYDD3k23XGks/VeO5ulQ+XYR247wzr4pG7YenuotwIg6qnJnQdrbYxkLwuLhrGzCCWdznZpnICJzDWDBLsCyBXL/AjzHsavcxBcFl+KArleGx1/0T+zGa9LSotrjuwruomiknMtIOXsWB5qzJTUfbPtrDFm6rs6cYmj4irgUAaJf74hSW0e0HMqpO61zdTPHQsiYCxETjjHjlfVhoVMhF//MgZPvI/CeGerU4IErKs4oltKJ4yjo8+X4cplPAQ9tme8nnpPlNw/cJahSfwY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZFhIMTdVQlNkVEhYNktyS0loanBaL1lyeHJxeEtQNzVaWmZoKzRsSnhWd3VD?=
 =?utf-8?B?dG03YitGbTlPWGtTYVZFZ3VURHFvU3pmb1EvMDkxZHNRVElIU3NEbmRNZHRR?=
 =?utf-8?B?ZnhYNld4YWtRZllZR0ZvTm5FdDZ6bk8rS3NDVWoyRkY1TFJsUit2ZkR4a2Ft?=
 =?utf-8?B?Z3BTd0pWS0ZrWmJ4ME9DanFFZ0UrM0lTMzVNZjV3cFFkMEdPdytEWmJYVlU4?=
 =?utf-8?B?Z25HVmFkN3NKUC9aejUyMTNZR3lhVVNIK3VBWGJqRTRHbXpTSC9ZY0krWTd4?=
 =?utf-8?B?ZXJKS0dSd2I1QnJ0aEtoaGxDZ2xrSGZUUVdsVVBSSDJ0YmpuaTZnbGN5c04w?=
 =?utf-8?B?R3pUVHgrK3NMajRERHN4b1BUd25hMlV6NGhSNnJqM3l1YXZUZTMrYzNwQ1pL?=
 =?utf-8?B?VkdGcTh5YXpmcGdkN0dHbnlUcHNQajdqek5HZnZIdms5SllGS2JPeTEvd0NX?=
 =?utf-8?B?NmJ4SFNGaHNPYWVMNmdPcmhxTW5EY3FCcGlFMWU2L1VpbGowbUZLY2R2UHlJ?=
 =?utf-8?B?V0ErV1hCZG5TSE5welRxcjNGUVBMcmxEQmdJRHdmQUpnQXBkbndoUVZzZE9p?=
 =?utf-8?B?cFA2VlhXTWQ3azdRWXF2eGd3Yk1tZGkydzJyU01mVDQ4M3dQSjl3U3piNzNJ?=
 =?utf-8?B?bDczMHp2aW5vVFRMczZUdmk2Y2UyOUozQjlqL25uVTNsNHlqMXByc3NHRmNx?=
 =?utf-8?B?VEhXMmpHVldwaHRvaDdIS3BBc2h1R0dEZXJ3UDV0R3RYeHJWQjdtNHI3YWVJ?=
 =?utf-8?B?U1V1V2QvWEpucFJNbG9kbGRKaEtUbWRIQWZOdGNDY2doakdsc0Q5dXdFY2t3?=
 =?utf-8?B?RG1mODBScVNXemE3YUhaMHh3SG9SVSs5SGxiaVFrdExadlpMd21EUWlPNmVr?=
 =?utf-8?B?ZVBnZVdOT1JWS2crYmM0S253eEdJSmtwOFU2WTdlVUdSbTZiUzhrbWtPc3ZM?=
 =?utf-8?B?QURQN1R0aWNMRERzV1hnNkoxS2d6R1RZcE1GdUF6WXpWYVhHK21Qc2tBMHE5?=
 =?utf-8?B?OERWMmNDUGtTQ2hVMXJ0M0tPQURSZWViV2pYUjhMUTJVeGNZWlRtR3NoNk40?=
 =?utf-8?B?SUhJTTkyS2VIOXArZUFWM00xYWVwNm9zbndmbmE3Yng2UitFRUxWcm1tbUtp?=
 =?utf-8?B?bDJHK1Mxc1F4V3Q0OHhiNDhkVUwvQU1jdmZUalVWSzlJdGc1b3JTUHJBSmRl?=
 =?utf-8?B?TFYwcENOa2JvTjZoRnY0WHZIM2xuUTRuUFlYZldwVThNSjhZMUVERCszbEUw?=
 =?utf-8?B?a0dzNmxKQm9IN0x3eUNaVUkwUlF5V0JqTHd6RE1EcVVTKzdOdEJIUkFNQVpz?=
 =?utf-8?B?b1pYbmJHb3ZLSkc0RE0wa0pMS0pja0IvRHh2WlpSNDFsMDNGTGlPWWZndlgv?=
 =?utf-8?B?NlRUSFFseWNZNzRXc3h3aldmMUU5ejA5NXFFLzA4N2xyRWc2TWpuRXlNOXVU?=
 =?utf-8?B?Z2dxb3lvL3hrYmhxSGFVcm8wRzJVWm9Od2xDT2dBVTVqeU1tdkQ1aWJhQVQv?=
 =?utf-8?B?QzNsQ29ZaWR2dERlODdXSjFCREdYNndKak9pZUtsMzhCU1Z5UlZCZHpKaHM3?=
 =?utf-8?B?cEUrYmFjY0hvMHNEZ2Q0UHo3dUZJZUZ5M1V6UFRWN3lYWkREQm1KWWMxY1BB?=
 =?utf-8?B?QTJRbmx1VUtYSnVnR0t6N3FMNHlDQm9kNitwNXhXZjNqQVh4QUhMM3V4TE9v?=
 =?utf-8?B?TGdlREl6d3l6dndMT2pTKzhkNEJwMU1ZRGZ3Y01JS2llZmkyVjBTRzQ2eTBU?=
 =?utf-8?B?TjdTVEFxbnQ3ZGJpYndXR2VCcU8rM3ZFU3orMkV3Q084WENOYXJMWUUyTXhR?=
 =?utf-8?B?UjVlS2JQOUoreTNmWEFIY2J1S0M1eFBmcEZsdkZXOTRaQVJQTW1ZSzlzTDd2?=
 =?utf-8?B?ZVcwTjBCOWROVUZrT3ZnZDUzK2Z0UWdPeFRkSEh5bFZ0dXNCUUthZGNxTkVH?=
 =?utf-8?B?T0d4bVBrbnoyOUhBcHhRRnVLTkpJQk5qeTg3WTNHeWlLYmhTUlViT2xHbG9k?=
 =?utf-8?B?ckRVOHhaelFZSWl2RzZMZmc3V3hLNWJaRlk0N0JhV3JzMThVK3J1SDlnSE5p?=
 =?utf-8?B?Unp2Q29QeW5qQkMvdVp2ekM5eTVncEoxUXhhdi8vajA2dDNkems4azJDMkx6?=
 =?utf-8?B?THJYMzJ4TWVXN1RNRUZ1bm1KaTN0bVpBVVhrUmxZQ1NIOWxzS2lWQ2NrN1Bk?=
 =?utf-8?B?NXFZVDhya0ZHZTRrUXpBRHhaY0RuMm9QSHViaFhLTUxNZ3UrK1RBTCtKSkd2?=
 =?utf-8?B?NXBIS1REZWtTTm5MMkhkUFQ3amI2Wk83cDJZMTVUTnljRnpUeDJDcXNBd041?=
 =?utf-8?B?bUlVb3FQK3h6bzdPNzRMOHExOG5wUHNJWitTQ25VaVFyeWdvMnMrQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFCFAAB3B530C845B679476493C910D7@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1437f14c-b637-44d5-560f-08df08caee6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 08:19:38.5992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LyaOc6//QG1dCK1VSWRUE3HrdhfLhI7sFGXp9tEK55fzH1e8myxmp2nNx9IR8A1QNHA8i3Puzn+p2Xeez+KveZz4sCLv8wGgH7w0yUeLAkA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7096
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Sep 2026 08:19:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24054

SGkgZXZlcnlvbmUsCgp3ZSAoU2llbWVucykgd2lsbCBwcmVzZW50IGEgQ0lQIGRlbW8gKCJ0ZWNo
bmljYWwgc2hvd2Nhc2UiIFsxXSkgYXQgdGhlCkVtYmVkZGVkIExpbnV4IENvbmZlcmVuY2UgRXVy
b3BlIGluIFByYWd1ZSB0aGlzIE9jdG9iZXIuCgpUaGUgZGVtbyB3aWxsIGJlIGJhc2VkIG9uIHRo
ZSBpc2FyLWRlbW8gWzJdLCBzaG93Y2FzaW5nIHRoZSBmb2xsb3dpbmc6CgotIGlzYXIgaW1hZ2Ug
YnVpbGQgKHVzaW5nIGlzYXItY2lwLWNvcmUpCi0gZ2V0dGluZyBhbiBTQk9NIGZvciB0aGUgZ2Vu
ZXJhdGVkIGltYWdlIChnZW5lcmF0ZWQgdXNpbmcgZGVic2JvbSBbM10sCnJ1bm5pbmcgYXMgcGFy
dCBvZiB0aGUgYnVpbGQpCi0gcGVyZm9ybWluZyBhIHZ1bG5lcmFiaWxpdHkgY2hlY2sgb24gdGhl
IFNCT00gKyBpZGVudGlmeWluZyB3aHkgYQp0cmFuc2l0aXZlIGRlcGVuZGVuY3kgd2FzIGFkZGVk
IHRvIHRoZSBpbWFnZSAoImRlYnNib20gdHJhY2UtcGF0aCIpCi0gdXBkYXRpbmcgdGhlIGltYWdl
IHVzaW5nIFdGWCBbNF0sIHdoaWxlIGZvbGxvd2luZyB0aGUgcHJvZ3Jlc3Mgb24gdGhlCldGWCBV
SQotIHNob3dpbmcgdGhhdCB0aGUgbmV3IHZlcnNpb24gaXMgbm90IGFmZmVjdGVkIGJ5IGEgcGFy
dGljdWxhcgp2dWxuZXJhYmlsaXR5IGFueW1vcmUgKHJlLXJ1bm5pbmcgImRlYnNib20gc2VjLXNj
YW4iKQoKT3VyIG1haW4gZ29hbCBpcyB0byBkZW1vbnN0cmF0ZSBwcmFjdGljYWwgY29tcGxpYW5j
ZSB3aXRoIENSQQpyZXF1aXJlbWVudHMgLSBzcGVjaWZpY2FsbHkgYXJvdW5kIFNCT00gY3JlYXRp
b24sIHZ1bG5lcmFiaWxpdHkKbWFuYWdlbWVudCBhbmQgc2VjdXJlIGRldmljZSB1cGRhdGVzLiBJ
IGhlYXJkIHRoZXJlIGFsc28gd2lsbCBiZSBhIGRlbW8KZnJvbSBDSVAuIElmIGFueSBhbGlnbm1l
bnQgaXMgbmVlZGVkLCBmZWVsIGZyZWUgdG8gY29udGFjdCBtZSBvciBDbGFyYQooaW4gQ0MpLgoK
TG9va2luZyBmb3J3YXJkIHRvIHNlZWluZyBtYW55IG9mIHlvdSBpbiBQcmFndWUhCgpbMV0gaHR0
cHM6Ly9lbGludXgub3JnL0VMQ0VfMjAyNl9UZWNobmljYWxfU2hvd2Nhc2UKWzJdIGh0dHBzOi8v
Z2l0aHViLmNvbS9zaWVtZW5zL2lzYXItZGVtbwpbM10gaHR0cHM6Ly9naXRodWIuY29tL3NpZW1l
bnMvZGVic2JvbQpbNF0gaHR0cHM6Ly9naXRodWIuY29tL3NpZW1lbnMvd2Z4CgpCZXN0IHJlZ2Fy
ZHMsCkZlbGl4IE1vZXNzYmF1ZXIKCi0tIApTaWVtZW5zIEFHCkxpbnV4IEV4cGVydCBDZW50ZXIK
RnJpZWRyaWNoLUx1ZHdpZy1CYXVlci1TdHIuIDMKODU3NDggR2FyY2hpbmcsIEdlcm1hbnkKCg==

