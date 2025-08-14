Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F336CA0ED1
	for <webhook@archiver.kernel.org>; Thu, 14 Aug 2025 05:35:10 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.16193.1755149703670796141
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Aug 2025 22:35:04 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 57E5Z0O4216678; Thu, 14 Aug 2025 14:35:01 +0900
X-Iguazu-Qid: 2rWh5b6vJh9VdjLOjw
X-Iguazu-QSIG: v=2; s=0; t=1755149700; q=2rWh5b6vJh9VdjLOjw; m=TW8dnKpQaEnrkYVEsbUDPIWNQ6Z+hom1goljqv43S38=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 57E5Yxku3824553
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 14:34:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJYc2Z/kzSNRGuCcpM06GY8i6Xs03hl1SbQ9WiGAqJlFS++FGNrKCSU2lQ90XVZPUVo4V/IqjAvqHOQGVrjcGS3CSysggrunJjsaNqdMR0yJIbtejjJjl+m9Y4O5nIUqEDn8GPP6yAml4Vw7IPSjeg0F1N0J3qmaGO8DiJeSWfiYuA0eeNCovq8UMEhx5xmrukVZbGsMiNETkilb9seXtLVBDAB1JjSxF13qJuR3JPIk18bj1ITMBwDhE9yRT1WXm8gu88tdxlqvqBP3IMQ39rElGq7ENHYCRcY7veZS8KXoTMw4D+2CJ9NMDmiaspZFLSni9Vg67dfjLBTN/ZwUGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mK2vTDJyQVjMdSpqxEk2PuhwMxb9QB6n6Bawcr7mIoI=;
 b=QPY8z7S5GxKSNOB4XfcgEJy50HKiL30zI9QVoYgeEFr3pK35j+kJVCJcCFWi1yjWSWn6tYnf4O68cGDjkcjaEvKBY7ysUwDxyYMj34fuCfZtFItLfCL55jBAS2pFyKCNS1JmKMDfgw/Fbkui51FtTyldLxqaEAbEQpcKPZfNHD5rQd4UNxpXlp1GWingWbo22ajYkZZ4T+HfRwEPweNNg2NLsWmXDY8wwLkBqevhA1gz6uu4nLGUOoRuq68T3SAmR/XsBYnmXySj2TuqpfmyZKIrFID3M8PYrwBNwlDj2wgNsgMe2YWCG0vBeEQg3RDXqItzFuVyPcpqkc7/bSPcog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [isar-cip-core][PATCH] swupdate-handler-roundrobin: Update
 revision for rdiff_file handler support
Thread-Topic: [isar-cip-core][PATCH] swupdate-handler-roundrobin: Update
 revision for rdiff_file handler support
Thread-Index: AQHcC2zO1gJrNqTVuk2gCEwRuzUb0bRfdi2AgACHbPCAACL2gIABgaIw
Date: Thu, 14 Aug 2025 05:34:56 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB110751B54BE4D0B82FA7C7613C735A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
References: <20250812092815.1282546-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <ec5c9daa-5dbc-4073-a0ff-228ab91444d5@siemens.com>
 <TY3PR01MB110752C228BA5A80A92B09B55C72AA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <5d939d03-d437-4c20-a774-a2b9835434cd@siemens.com>
In-Reply-To: <5d939d03-d437-4c20-a774-a2b9835434cd@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|TYRPR01MB16152:EE_
x-ms-office365-filtering-correlation-id: 23289bb8-5946-4126-5991-08dddaf44d89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?SVFZemFSRXUzVGJteGVkOEdwcGVuQmVYREVUVUdwVVp0UTc5TEZwWTBaOFFm?=
 =?utf-8?B?TnhvRmU0UlFjVDZKK2dCRjF0RmRkN093dVE0VzVWNGhXbE81ZmlZZVJoL2hi?=
 =?utf-8?B?dzg3ekFiZjFGek1BMDJOYjg0dU14cWd3VEo2bHJhMlcwQWtKTEhvSC9mUzZS?=
 =?utf-8?B?LzBDOFhCR1RxMnpqdmRvVDIrd29oZGxkemliWFI4RmVNaXA0eVFGN1A4dDRT?=
 =?utf-8?B?Q0lBcUtnMms5ODVuRW1aZkJqazRrUmprMnRhVGZIU3U2R1lnTmg5M3p0WGx1?=
 =?utf-8?B?cXpWNm15WUduQjV4REV6K1J4MVBOU3pIWUk1bnVqQW5CNWQxaTlmRlhlbU9v?=
 =?utf-8?B?WCs2Zk11Qm1VSTFoY21PeTF6RzhMUE9LdGF2dnFGMW8vMWQ0SldOTndqOW1G?=
 =?utf-8?B?bFZPbFBkWEpYS2NKRjNGQXJzQXRpeGwwWkVWNlFkNDRHeHA2ODdPam53eDlG?=
 =?utf-8?B?VUxwWUJuZEcvc2s2aHQzMTBXT1ZiN3B4TFhDWjRaK1RpY0g1eE16WjZwOVFZ?=
 =?utf-8?B?K1BQeVpQaStPZEFSeFJPci9wRHV4N1Z6THhBZ1l6NmlMZEVXbXF6cVlOZXpE?=
 =?utf-8?B?MjFjUTVCS1JFM0QvUjNVWkQxd1A3TW5wN0sxT0FRbnRRdDJSZ0JSTTZiWHZ2?=
 =?utf-8?B?WHp2WjB0TTM4WkREZGtWSlRxMHZ6NjlzV1JnT0xOQWQzV0JIcXJOUXBYRkcz?=
 =?utf-8?B?dHBaclNmNmZnTmZLUGtuWXFwM1JjeVdFSHBqVmFsMlkySnpEeU1Nd3ZJVmFW?=
 =?utf-8?B?bjRHRGhhbGJEVnRLOVRNWklxZDh0NlRoMElwYVFrTUtzNkN5UmpVTEpubDZk?=
 =?utf-8?B?MWJKNldibG1VVDRQUUQyZkI3aTZJSytISlJ4WkgvY01rUndLNkVnM1RTUjd3?=
 =?utf-8?B?Q2xtRlRFQk5YYTZzdVdiT0RTQndIdlRhNDBRcmpyVFdIUVl5bExvN0dpTWJP?=
 =?utf-8?B?dTczem03TDhjd256eDVYazh5Q0UzbXg4M0ZsSnU3a0VOdCtwME44OTl3Nko2?=
 =?utf-8?B?bDNiNXg2OHdXc0NRd3V5QTlmTFJJanpFQm56QXNUOXJ0TmppTi9RZTVRMHpT?=
 =?utf-8?B?N00wMXhoQkJZUHFRRkNZS1lZMVl3MzR4akJ6YTJJQW9JY1Axd01TYXN2ekRO?=
 =?utf-8?B?YWlIUE9obTYrbDZYaSs4SlBTSjdXblBMLzRtc1dMcGlRejR3QmRUNS9lblA5?=
 =?utf-8?B?M1ZUdDFLZzg2VnowQ0pIejQ4NU15ZEROZUNPK1JqdzdtVmJ0WGVjTmlMRTdR?=
 =?utf-8?B?QmlNQVhIbzlzaHFvVGRBSDNhbTkxZnFxQ1NrZTJlVkpORFc0b1pvMEs5cFUr?=
 =?utf-8?B?VWdMN1RvSG5WYkRTN2VNNHh3c2FPcGNMa0ppazBnemtncmpYelJ5S2NUeC82?=
 =?utf-8?B?NnhJQTNCNVlvbVB1NHpDRE1zdVFFYldMVnRIQU85Q054ZS83OFlNZnBMRTE2?=
 =?utf-8?B?K1RLcVVVYTVJSExtd0FHV3VicklKME83bmZZeHdkVHJEM21OZGtLSDcrSFNQ?=
 =?utf-8?B?QU5kNURTdFFtTEI5L1M1SEEzaWFrRzFlZ0pIMkdBY3ZhMXlkL3NZdTlYSGdO?=
 =?utf-8?B?K2JJbndDblRkMFhIUDBlZkZNZ3gyNGJYWmJlRi9qZFQwZ3NNY01JSEp1aW53?=
 =?utf-8?B?Q1NmbVhxWUE3ZElOSUsrd0VHcmxpOFE3KzhCcURBLzFSKzIzU1Bic2g4SW83?=
 =?utf-8?B?ZFIzOUxrRVhMUTMwYTMwcWx0YW00OGIwYlNUZWZTMTAzRHZHNVBQSVhXRjh0?=
 =?utf-8?B?YzBhQmp3VFNzMk4yLy9tM1NzdHhXc0tBOXNDVWE3UEFCTURULy9QSlZBVTdY?=
 =?utf-8?B?Y1pVcXJMekRvVkIvTWJ5SnFSbGxXZDh2R1BDVXlwSXJLY2pQY0d4UUhKbGl0?=
 =?utf-8?B?UGN1Y0wzSXlrN2RtK082SVVVM0hUa1Q5MmZiUndFcVJQOHhMYUxOd1RwUFVr?=
 =?utf-8?B?eUhTSG1NS2V2bnRQeGNwRkxoUEhnUStVQy9wRnhRblRNUkFUWVJPZjRUNVM1?=
 =?utf-8?Q?MtYCbYJ6bXQM0ZpfY9OTaeaKtRO3eo=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dzhNcXVWb2dFdkVrMnRXRG5VSlFDSlJoZU95MTFGSXNwYXV0Yll5ZFlZMzNR?=
 =?utf-8?B?bVliUDdFREF5Y1AxakNDeXpjNHN2dU1haFBjbWUrV1d6Z04rcjJwSW5VbnNh?=
 =?utf-8?B?b3FDU1dWV2U3S2E3WmpiUlNISlk0TGtMSkxZTWF2dlhiOWFXd2ZVMldSd2x0?=
 =?utf-8?B?Z201TnVQMHY3RkZWVVczaU1Wb0Z3RmprK0paTVFCZGF2UnFmdHFwdkY2Ykkv?=
 =?utf-8?B?T3p4ZUxpRGNhcnFrR1lhV1JWWXVqMHUzZEwrcjJvWDNxL1hHU2J3RFN6OTlL?=
 =?utf-8?B?SXNLWllUQ1hBWkMyT3Z3YjlWY1lDS3hsLzI4UXBaNTBCQ3hPdm5nTm14N3Uz?=
 =?utf-8?B?ektIMG5GNGNVbXp6bFpMU0o0cmZxT0pEZjFIVHFrc29MUWJPNjBVZlVJSUk5?=
 =?utf-8?B?dzJXVUkxWXlaQ2Q1T1lTLzlNYW1aS0tHWTNpMnV1RkhidDRSMEJqbTN4TXdH?=
 =?utf-8?B?OFRkM0pSMWZzNzRKYWFCMjF4NlNhTUJoZEV5Q2JTRitLako1dHloUWdmQ25t?=
 =?utf-8?B?dFVjajllMHlmdHc4R2ZzOGVWWmdnVC9QWWp3dy96RS9jZlBrMHFlVDJhOG8x?=
 =?utf-8?B?dzVqQzJyQ1ZMQ3VkUjJrM2dIbHlVNUhUZ3hpNEdUcE5kVHNjNDhack5SYWlm?=
 =?utf-8?B?TlRZYXp5MWU0c3FtZXlFdEYzb2VkZmh0NGlOVlkrS0dubkNNTVQ1eGhpYm1T?=
 =?utf-8?B?Q29XaGhKbHZRTzQvR3NxQ2tPVTNrWUpNVmhQNytkNkgvNDNJKy9FVVlXY0t1?=
 =?utf-8?B?ZnU0cjNFT1llbVYxOEhuQ2cwUVlsR0EyYzlqQ0VCanM2aTViSDU0R1pEMkNL?=
 =?utf-8?B?eC8xWmQvclJhUm9HYWFpK2RCNTVZUU1IZnVsdXR0MzMyOVFNeVNwUHc3bXJh?=
 =?utf-8?B?VWY0QmxKa3g0K0U3WldlUFZIaHNVVEdReGNYQ3oyWHRMWXI3WkxWQlRXV0Nz?=
 =?utf-8?B?SFNjOFpvOStVZmJsdkpha0UvUm4yaUx6eFdEODBFTVFSYTd2bER4N0F3a1VZ?=
 =?utf-8?B?dTlvQU5jcG96UURMcEhCWnk5YWd5bTFDWUlOc29OclI2YnM0M3BQa0phTGlC?=
 =?utf-8?B?SHRIMlN1bXhDcmoybnE2TDczTzY0ZEVwR1RjWVp2MUI1RldHSjAvWmNheVNw?=
 =?utf-8?B?azRabys0Um04RFFrYitUQ3FvMEU1UzE1cHpnMFhud1ZKOTdWTUJNbldZR1E0?=
 =?utf-8?B?Rm1rUU15Z0VNOGMvSlBRRDNRbXo3ZGhrelBNd0NNWHJid0xnTkJPRVZ5Z1lX?=
 =?utf-8?B?cFJ1Q2pxeDVoOFkvSVdJNHVnQlVqUzA5L1B1VGVWay9ldXFtSjBIMnhuSmtj?=
 =?utf-8?B?RVdEQ0dIN3RXZ1BWYWVWR2JjVkpvOGY5eFlBZjNxUUpWSHVkcTVtS3BJQnZC?=
 =?utf-8?B?Y0hmUktCZnovR2Vwc1N5N3d0ZFd5R3Vtb1FyVVRzek9uQ01KRGZZSENEVWhP?=
 =?utf-8?B?MzBqS2YwaUlrMFpRZnhzbUJ0bHJtNnNheGVWdTN2QkRodENEVXRFcEo0Y21J?=
 =?utf-8?B?ZVRmUnE3TFJCNktVZGxLNm1RT0E1ZGtBK2d2aEVKcGdhL0JCOXJZd1lXT2xR?=
 =?utf-8?B?RkdPbGRVTzY1VUt0eUM0amFBU25LbWRTdUdFYUJGcmpvZStRT1dHY2kwdFZq?=
 =?utf-8?B?MUNBNDJHNXVqTTMxSTcyd0xvamFjck5rWGVwZEVXc1pyU2tTRXY5UUMrWVBL?=
 =?utf-8?B?dDlPaUFpQ3dUeGcrNzk4d2dpbXI3eHFUYURUMFZkc3hMVGtJUlIybVVJemkx?=
 =?utf-8?B?L05sUnJtUXNySTE0QWxjM20zN2NxcmhGMUNubzlaTmxzdnRjVm9zMXhUc0lQ?=
 =?utf-8?B?UmhoWGs0b0syOWlUc1hEVnNROUxUZ09MYkw1K3JlSVl4eHNONmoxOC9xdGhK?=
 =?utf-8?B?SDFrNHVJWXc1NEtzNGNsMjBTdTc1M2UrZU9BRnpYYllUWmQ5YUVmN0tIdmFr?=
 =?utf-8?B?NWtGYnRmdlpHWWl1OXlJREpRaXNmZTlneCswQ1NRMGtKSHdGOXB0a1p4aFVL?=
 =?utf-8?B?OUYveGQvaDh6bDlrY3NMVTJTbS9KelA1OWQ0M2ptNzZwVnpsb0h2d0h6eFVk?=
 =?utf-8?B?WGVxVU41RGkxb0xBRVJCNHBSTzQwWlBvNDlNcTd2VzhUbXRDRmo3U2dzRzIx?=
 =?utf-8?B?REVZSlNBZUJWMlYyeTFGQU5NdlN4aFRZZ1BYTCtuRUo3NnBjRHNNY2FocEVw?=
 =?utf-8?Q?Vf4HvYtx0OWxUyMrPyIg0MM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23289bb8-5946-4126-5991-08dddaf44d89
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2025 05:34:56.4143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1K7cNHbdXP5lzVw7Bfkpr1m2e4jEZ/mfi0uM9if1Y6q4IAnsT+2r35ElJ1VtMDu7PJ3HAbHjtWcYvGw9gKMLXkmzwp3lGFYyL9fh3FthdJc9egKWWl9wrKEKck+IE7fM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB16152
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Aug 2025 05:35:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19737

SGkgSmFuLA0KDQo+RG9lcyB0aGlzIHVwZGF0ZSBvZiB0aGUgaGFuZGxlciBicmluZyBvdGhlciBi
ZW5lZml0cyBvciBuZWVkcyBtb3JlIHRlc3QgZXhwb3N1cmUgYmV5b25kIHRoZSBuZXcgZmVhdHVy
ZT8gVGhlbiBJJ20gaGFwcHkgdG8gbWVyZ2UgYWxyZWFkeS4NCg0KTm8sIGFwYXJ0IGZyb20gdGhl
IGRlbHRhIGtlcm5lbCB1cGRhdGUgY2hhbmdlcyB0aGVyZSBhcmUgc29tZSBjaGFuZ2VzIHRvIGx1
YSBjb2Rpbmcgc3R5bGUgYW5kIHVuaXQgdGVzdCBjaGFuZ2VzLiBBbnl3YXlzLCBJIHNlbnQgYSBj
b21wbGV0ZSBwYXRjaCBzZXJpZXMgaW5jbHVkaW5nIHRoaXMgcGF0Y2ggdG8gZW5hYmxlIGtlcm5l
bCBkZWx0YSB1cGRhdGUgc3VwcG9ydC4gU28geW91IGNhbiBpZ25vcmUgdGhpcyBwYXRjaC4gICAN
Cg0KVGhhbmtzICYgUmVnYXJkcw0KU2hpdmFuYW5kIEsNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCkZyb206IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+IA0KU2VudDog
MTMgQXVndXN0IDIwMjUgMTI6MDANClRvOiBrdW5pamFkYXIgc2hpdmFuYW5kKO+8tO+8s++8qe+8
sCBESVRDX0RJVC1PU1QpIDxTaGl2YW5hbmQuS3VuaWphZGFyQHRvc2hpYmEtdHNpcC5jb20+OyBj
aXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KQ2M6IGRpbmVzaCBrdW1hcijvvLTvvLPvvKnv
vLAgRElUQ19ESVQtT1NUKSA8ZGluZXNoLmt1bWFyQHRvc2hpYmEtdHNpcC5jb20+OyBoYXlhc2hp
IGthenVoaXJvKOaelyDlkozlro8g4pah77yk77yp77y077yj4peL77yj77yw77y0KSA8a2F6dWhp
cm8zLmhheWFzaGlAdG9zaGliYS5jby5qcD4NClN1YmplY3Q6IFJlOiBbaXNhci1jaXAtY29yZV1b
UEFUQ0hdIHN3dXBkYXRlLWhhbmRsZXItcm91bmRyb2JpbjogVXBkYXRlIHJldmlzaW9uIGZvciBy
ZGlmZl9maWxlIGhhbmRsZXIgc3VwcG9ydA0KDQpPbiAxMy4wOC4yNSAwNjoyOSwgU2hpdmFuYW5k
Lkt1bmlqYWRhckB0b3NoaWJhLXRzaXAuY29tIHdyb3RlOg0KPiBIaSBKYW4sDQo+IA0KPj4gSSB3
b3VsZCBoYXZlIGV4cGVjdGVkIHRoaXMgdG9nZXRoZXIgd2l0aCBjaGFuZ2VzIG5lZWRlZCB0byBk
byBkZWx0YSB1cGRhdGVzIHdpdGggVUtJIGltYWdlcy4gT3IgdGhhdCBhbHJlYWR5IGFsbCB3aGF0
IHdlIG5lZWQgZm9yIHRoYXQ/Pw0KPiANCj4gQWgsIEkgc2VlLiBJIGhhdmUgbWFkZSBmZXcgY2hh
bmdlcyBpbiBpc2FyLWNpcC1jb3JlIHRvIHN1cHBvcnQgZGVsdGEgdXBkYXRlcyBmb3IgVUtJIGlt
YWdlcyBhbmQgdGhvdWdodCB0byBzZW5kIHRoZW0gc2VwYXJhdGVseS4NCj4gTGV0IG1lIGtub3cg
aWYgeW91IHdhbnQgSSB3aWxsIHNlbmQgdGhpcyBwYXRjaCBhbHNvIGFsb25nIHdpdGggdGhvc2Ug
Y2hhbmdlcy4gU2hhbGwgSSBzZW5kIGEgc2VwYXJhdGUgcGF0Y2ggc2VyaWVzIGluY2x1ZGluZyBh
bGwgdGhlIGNoYW5nZXM/IA0KPiANCg0KRG9lcyB0aGlzIHVwZGF0ZSBvZiB0aGUgaGFuZGxlciBi
cmluZyBvdGhlciBiZW5lZml0cyBvciBuZWVkcyBtb3JlIHRlc3QgZXhwb3N1cmUgYmV5b25kIHRo
ZSBuZXcgZmVhdHVyZT8gVGhlbiBJJ20gaGFwcHkgdG8gbWVyZ2UgYWxyZWFkeS4NCg0KSmFuDQoN
Cj4gVGhhbmtzICYgUmVnYXJkcw0KPiBTaGl2YW5hbmQgSw0KPiANCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4N
Cj4gU2VudDogMTMgQXVndXN0IDIwMjUgMDE6NTANCj4gVG86IGt1bmlqYWRhciBzaGl2YW5hbmQo
77y077yz77yp77ywIERJVENfRElULU9TVCkgDQo+IDxTaGl2YW5hbmQuS3VuaWphZGFyQHRvc2hp
YmEtdHNpcC5jb20+OyBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBDYzogZGluZXNo
IGt1bWFyKO+8tO+8s++8qe+8sCBESVRDX0RJVC1PU1QpIDxkaW5lc2gua3VtYXJAdG9zaGliYS10
c2lwLmNvbT47IA0KPiBoYXlhc2hpIGthenVoaXJvKOaelyDlkozlro8g4pah77yk77yp77y077yj
4peL77yj77yw77y0KSA8a2F6dWhpcm8zLmhheWFzaGlAdG9zaGliYS5jby5qcD4NCj4gU3ViamVj
dDogUmU6IFtpc2FyLWNpcC1jb3JlXVtQQVRDSF0gc3d1cGRhdGUtaGFuZGxlci1yb3VuZHJvYmlu
OiANCj4gVXBkYXRlIHJldmlzaW9uIGZvciByZGlmZl9maWxlIGhhbmRsZXIgc3VwcG9ydA0KPiAN
Cj4gT24gMTIuMDguMjUgMTE6MjgsIFNoaXZhbmFuZCBLdW5pamFkYXIgd3JvdGU6DQo+PiBUaGlz
IHJldmlzaW9uIGluY2x1ZGVzIHRoZSBzdXBwb3J0IG9mIHJkaWZmX2ZpbGUgaGFuZGxlciB3aGlj
aCBpcyANCj4+IGhlbHBmdWwgdG8gdXBkYXRlIHRoZSBzaW5nbGUgZmlsZXMgdXNpbmcgcmRpZmYu
DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogU2hpdmFuYW5kIEt1bmlqYWRhcg0KPj4gPFNoaXZhbmFu
ZC5LdW5pamFkYXJAdG9zaGliYS10c2lwLmNvbT4NCj4+IC0tLQ0KPj4gIC4uLi9zd3VwZGF0ZS1o
YW5kbGVyLXJvdW5kcm9iaW5fMC4xLmJiICAgICAgICAgICAgICAgICAgICAgICAgICB8IDIgKy0N
Cj4+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+
PiBkaWZmIC0tZ2l0DQo+PiBhL3JlY2lwZXMtY29yZS9zd3VwZGF0ZS1oYW5kbGVyLXJvdW5kcm9i
aW4vc3d1cGRhdGUtaGFuZGxlci1yb3VuZHJvYmkNCj4+IG4NCj4+IF8wLjEuYmINCj4+IGIvcmVj
aXBlcy1jb3JlL3N3dXBkYXRlLWhhbmRsZXItcm91bmRyb2Jpbi9zd3VwZGF0ZS1oYW5kbGVyLXJv
dW5kcm9iaQ0KPj4gbg0KPj4gXzAuMS5iYg0KPj4gaW5kZXggYTE4NWYyNS4uZDJlZGJiZCAxMDA2
NDQNCj4+IC0tLQ0KPj4gYS9yZWNpcGVzLWNvcmUvc3d1cGRhdGUtaGFuZGxlci1yb3VuZHJvYmlu
L3N3dXBkYXRlLWhhbmRsZXItcm91bmRyb2JpDQo+PiBuDQo+PiBfMC4xLmJiDQo+PiArKysgYi9y
ZWNpcGVzLWNvcmUvc3d1cGRhdGUtaGFuZGxlci1yb3VuZHJvYmluL3N3dXBkYXRlLWhhbmRsZXIt
cm91bmQNCj4+ICsrKyByDQo+PiArKysgb2Jpbl8wLjEuYmINCj4+IEBAIC0xMyw3ICsxMyw3IEBA
IGluaGVyaXQgZHBrZy1yYXcNCj4+ICBQUk9WSURFUyA9ICJzd3VwZGF0ZS1oYW5kbGVycyINCj4+
ICANCj4+ICBTUkNfVVJJICs9ICJnaXQ6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC1zdy11
cGRhdGVzL3N3dXBkYXRlLWhhbmRsZXItcm91bmRyb2Jpbi5naXQ7cHJvdG9jb2w9aHR0cHM7ZGVz
dHN1ZmZpeD1zd3VwZGF0ZS1oYW5kbGVyLXJvdW5kcm9iaW47bmFtZT1zd3VwZGF0ZS1oYW5kbGVy
LXJvdW5kcm9iaW47bm9icmFuY2g9MSINCj4+IC1TUkNSRVZfc3d1cGRhdGUtaGFuZGxlci1yb3Vu
ZHJvYmluID89ICJlNjkzNmI4YzI5YTIwY2I2YTY4OTNmYWFlNTdlMTI0OTllYmJjMzQyIg0KPj4g
K1NSQ1JFVl9zd3VwZGF0ZS1oYW5kbGVyLXJvdW5kcm9iaW4gPz0gIjVkZWI3NWRmNTQ2OWM1YTY2
Y2RkNzI3ZWI3MmFmODNjZTA3ODQwNTQiDQo+PiAgDQo+PiAgU1dVUERBVEVfTFVBU0NSSVBUID0g
InN3dXBkYXRlLWhhbmRsZXItcm91bmRyb2Jpbi9zd3VwZGF0ZV9oYW5kbGVyc19yb3VuZHJvYmlu
Lmx1YSINCj4+ICANCj4gDQo+IEkgd291bGQgaGF2ZSBleHBlY3RlZCB0aGlzIHRvZ2V0aGVyIHdp
dGggY2hhbmdlcyBuZWVkZWQgdG8gZG8gZGVsdGEgdXBkYXRlcyB3aXRoIFVLSSBpbWFnZXMuIE9y
IHRoYXQgYWxyZWFkeSBhbGwgd2hhdCB3ZSBuZWVkIGZvciB0aGF0Pz8NCj4gDQo+IEphbg0KPiAN
Cj4gLS0NCj4gU2llbWVucyBBRywgRm91bmRhdGlvbmFsIFRlY2hub2xvZ2llcw0KPiBMaW51eCBF
eHBlcnQgQ2VudGVyDQoNCg0KLS0NClNpZW1lbnMgQUcsIEZvdW5kYXRpb25hbCBUZWNobm9sb2dp
ZXMNCkxpbnV4IEV4cGVydCBDZW50ZXINCg==


