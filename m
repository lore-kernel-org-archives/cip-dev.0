Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2626AD7831E
	for <webhook@archiver.kernel.org>; Mon,  2 Dec 2024 13:10:09 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.173425.1733145005674693612
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Dec 2024 05:10:06 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 4B2DA3Dw222702; Mon, 2 Dec 2024 22:10:03 +0900
X-Iguazu-Qid: 2yAafc7cGv8yiAtVo0
X-Iguazu-QSIG: v=2; s=0; t=1733145002; q=2yAafc7cGv8yiAtVo0; m=5L3xjZbLea7Yb2QB1ToHTN13gxlbMXY2exagPBsJ2Tw=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 4B2DA2UI1565496
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 2 Dec 2024 22:10:02 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iuDt+DmeuXWsgKI4fRXvyZUfjIjCDkiikSli83lcN/XCkm705C9RfA070qDyn2K9rkF4/TKvicykSC3Kw/u7weBvMBYP+08Ptruiau4LubKL0PWscD8dHtvprltnpkt2ddGJtwc3TcaF7QePAqnw2+969iGsNXxhDSoXAD4O2smytsptBapyRWUGFNQEE+T/P3Qoa0v3lKdhDQ7xNkAAvkkvAfnUxmnnuzS9Tp/lAJy+uQXw50dI//ZG208gQxZJhV4bKi7Y2MYfjH8Kw+Z+66eeCjszvZFRi5wd9NHnZae6WaMipYJIW4KznuhxPwhNhv5GxmeEPmiN7LlBPpOzmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHhVxoJeEYnNL7E9HAJfg0URuOoK+s04iQRZ/kksdZk=;
 b=DXc2ZnIDZo7jSGIYRtPb77zRjLB9ktcVSRIt7uDqXUTHVXWojUM7jlVXiu3O39Bxl0Bkd68zBs/eA2q5/lT3eg08DdUqFWnY9ncOj+grnURXjuMDGi48pFRNq7amuwGblO+wi5Qh42qwbg9ERkeOZYghrtS8UttdDjJWkl2c3Mt3gOIK+VhFmi+AUfXww6WabBnm1tT0rhtPJpnhHK9Po69FgxNyhTwIpfDctG1y8FjdJOpbqK4OgOTtPvsrxMzKOUSk+psfgB3W47YmJbzzzwncgcmwvTYsvR+chyektc9vl9xFQLTEo0amyUeui91ftW1Qx7rTkq9ic7O6Ix9wtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <quirin.gylstorff@siemens.com>, <Chris.Paterson2@renesas.com>
CC: <kazuhiro3.hayashi@toshiba.co.jp>, <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Booting security image (.wic) on M-COM x86 in LAVA
Thread-Topic: [cip-dev] Booting security image (.wic) on M-COM x86 in LAVA
Thread-Index: AQHbQLwTUaTAYoFsNEu+W9FEgwfyArLLKo2AgAfBa0k=
Date: Mon, 2 Dec 2024 13:09:59 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6100E150797AAB51AD72A3B9C2352@OS0PR01MB6100.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103FB47A8576B2CFA3275F6C2282@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <434bc0cc-a0b6-4095-834c-ddd6a3fb2b09@siemens.com>
In-Reply-To: <434bc0cc-a0b6-4095-834c-ddd6a3fb2b09@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6100:EE_|TYRPR01MB13881:EE_
x-ms-office365-filtering-correlation-id: cb6315e2-00be-442a-0ce9-08dd12d2a039
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|8096899003|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?aXZERVc1bVYyTHdTckwrUGM2UzV2Rzg1L1BLR1ZDbE5ha3dZRFlETkNz?=
 =?iso-2022-jp?B?eHFYUmxKaVJ4MkVmRWRiNXV6NXhWeTNsU3QraDJYSnI2R2NCdTVKZVhl?=
 =?iso-2022-jp?B?K21wcVltTzNuZy9lbU1EQmYwbWVGOGVNV2NBaVlyb1JFZ2lYZlV4Y2Jx?=
 =?iso-2022-jp?B?VDNXWlNadjdFaC8vS2ZGSExvNllEd1JjT2F1Y1RLem9QU21Fck4wTzlD?=
 =?iso-2022-jp?B?N2RuYVVmUFFENkZudFpkOTkwaFp0WTdTR0hHT2d5ZitkZUIxWDRUUHNH?=
 =?iso-2022-jp?B?c09lT00wd05qZ2FsSTVRNlN0QmtYQUlxYnZVMjhQWTEzNVN6RWtPY0Vm?=
 =?iso-2022-jp?B?Z0tkRUo3aGZQVlVTVVd1bEpIM1JvNXhXMEZGalFlZU1LOVRLVTdyUmxG?=
 =?iso-2022-jp?B?aHZ1S0hTWnEzYVpWZkhSRzJ4WVZUMlVJWEVzMm5rWVp2T2F6S29tdTBx?=
 =?iso-2022-jp?B?bjQvNFNCKzVlNlhuQ2tGaEU2ckk3TzIyR1psYzQzYjdJckQzSitCeGZG?=
 =?iso-2022-jp?B?OVdzdUh6Z29XZkxldElqZStVeVJwTkZCcFRPVnBSSitkZGdDbUg3dXh3?=
 =?iso-2022-jp?B?aXU0UGRFTkY3cklVSjVFRER4cFVlTDQ3M21BQ24zOFFBblpEOHM0ZWtF?=
 =?iso-2022-jp?B?ZzhiTHJPSUhJZWs1UTEvWWt3Wm9nZHZvT0RDS0ZZNXNkWFJ2Z1lHU1VW?=
 =?iso-2022-jp?B?TXA2R1d1ZkxsbmZKQTVHRnNXUXlSdHFrQ1JMbjliS2xmbXVYSE4vQjZI?=
 =?iso-2022-jp?B?K082Ylczc043ZG5rN290bjNua1Nvb1dQWEFwTE9mRU4xakhOZVZsQkU5?=
 =?iso-2022-jp?B?V29qZGthZXp5cXpickhSZkQyL1BpL2NrZ3RmVFVWSEVFS0Z3UE1sem1W?=
 =?iso-2022-jp?B?QWpxc2JUUUp0ekxjYW82czhybTZxZVVIMGpwaXZ0U0RUUTkrUHFGbXpE?=
 =?iso-2022-jp?B?S2tZQ21mQ3grS2FlcFNhci9kSExPVHRKbTUxK3E5RUQ1OFc3MkU0MTNn?=
 =?iso-2022-jp?B?LytIVHRSR1g4bHQ0Qjd4eEwwcUtmSzhta2dxTFN4dCtOMlhOQ2ErSnAv?=
 =?iso-2022-jp?B?M3ZTT2VDb0tuZmgyb1ljakg3YlpvbG8yLzlOZGJ4aXM2WEdFSXkvWXoz?=
 =?iso-2022-jp?B?RDB3MkJFWXZVRWV3V3FXVUFZMzFpSWhVTmEvRjF4Um1WZFkvUTIxOS9a?=
 =?iso-2022-jp?B?aXdrc2h1amxESTk3K1BMdG0zemREN2JvcFJFUmtSci9haWRTeStub2xj?=
 =?iso-2022-jp?B?K2FGbjBvTmgzMEVyQ0s0bnlaQVdkK2svUHhnc2FjdTdBSmY3Mk9oalpB?=
 =?iso-2022-jp?B?RFdqNHJnaXNKcEFNeVk1endaOG5aZXN1YkR2RnJraTRZbmI1YUd5bUlz?=
 =?iso-2022-jp?B?dUE5ekNUdGxidkdxcnNUb29oUTJKaTBJOTA5Rlo4NXpMdXMrQmlPdTN4?=
 =?iso-2022-jp?B?QTlWaGYxWm5OOFozTS9NLzhkUkprVTlZMHhQbWVqZWlMUW1MeUNlZkE3?=
 =?iso-2022-jp?B?c2FIT3hXWkNVOTVYdUhLU0w0MTllQzByOG1kVmJYZGoyWkFjd0JLR3g0?=
 =?iso-2022-jp?B?VklSSzlzQ0JUR2xnRU5oY2IyVnVNTGtaeWxSQ2hOMlpKRUhDVDJBMHhM?=
 =?iso-2022-jp?B?RSt2WnBobTdqZ2FIL1I1QjgwNjlMSU5adGVsUVdPNC9CTktsamhGTE9J?=
 =?iso-2022-jp?B?NzlNcU42VG9xU2g3TWZyRnlVTlhhS0dJNlVZcUpEN2MzS2JUMm1LenVl?=
 =?iso-2022-jp?B?YzN0VVBNYm9QdlNqcXRJbzBTTWdlbG8vSm5ydUt5eCt3TloxMGwxSkFr?=
 =?iso-2022-jp?B?TEpvY0tvQktIZFJoR3ZlellxdTV6Nitxa1JNYUM5NHdrT2RHakpWbklN?=
 =?iso-2022-jp?B?TUVaMWE5c2YrK3BydHZTMExkY2h4ckpkYTZ6dDcvTkJzUFRSWmtHeEdC?=
 =?iso-2022-jp?B?dThEVHhtYmh6aVNaSmp0ZHJ0VkszQzBZa2FpNERKdTdDZWx2ZUNwOGJG?=
 =?iso-2022-jp?B?OStWcmF2d0ZMUDBsTXQySWxXK01tdXFXMzRYVXowSWNSQWo2cDhTRVVw?=
 =?iso-2022-jp?B?QXc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6100.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(8096899003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?TlRKYkZUOWRtdG5BVFlxenRvWUwrZkhPQzFQaVM5MDJlU1lkYU9oNjhJ?=
 =?iso-2022-jp?B?TlhuVDJhbXNGcGZvYXo5a1lkSC9CQURrSVdoM3pMbmU2NjZ0SENoTVZt?=
 =?iso-2022-jp?B?cXdiY3AxSnBOdXhYLzBSUVVTc0dwYkFJWWk1ZGM4dzlPdXB6bE15UFFs?=
 =?iso-2022-jp?B?L0hEVE5KREo2ZmlVOG53NmJ2UXJOL1dJQnp6ZHBGNEVXUTBjU2N4Zk5y?=
 =?iso-2022-jp?B?SzY2U2ZsUmZseUUrazc5Z2MyN0gwS0U0ekkrb0xseDU5N0ZyWXdEbUlv?=
 =?iso-2022-jp?B?cndId1RodDl3WjN6dmdjK2x6M3dGaEhPV1FuTVdUU1A4eG1jclh5MGJC?=
 =?iso-2022-jp?B?NUIvZ3pRZmVZMmxvK1ZuVjZBT1h1VEdBdTVnNy96SHpTQWZ1YlRJQjlT?=
 =?iso-2022-jp?B?Q2MvZ3M2blBFdy9mSG9LRjREWGxMQ2FoVHhmRWl0UzRiQjkzVDZ0Q21j?=
 =?iso-2022-jp?B?akh0bGN6TmU1L0ZkUyttcHVGemoyRGExbmNtTzJkSittYlNZMG1ESVVJ?=
 =?iso-2022-jp?B?WjArMnI2ejA5VVRvcks4SVRacXBLVDBSZjhDdjRtd2sweks2MDMvTmIw?=
 =?iso-2022-jp?B?SldwMHQ1UFo2NVR5TTI1cVNXNVpGTkU5SkhEbVlIaUx3UEg2NXhzWjlE?=
 =?iso-2022-jp?B?THY5dllSVGR6Y1B5UlhEQWlaWXFlcXBKeU40Mk9YbmpSUTY5LzN6VW1j?=
 =?iso-2022-jp?B?NEtnMHVMSVMrUG1yRUF1MFMwWHo4UGxWdWNvbDdteUVFN3JXbFcyRSt3?=
 =?iso-2022-jp?B?SFpjdHFXYTFJVnZueXRmakNuaW1lUmFoeHVtNWJRUnRsRTFCckNpYTZP?=
 =?iso-2022-jp?B?MUhoMXVYSFBjMFNYVy81RURvWm13R3hGTm9meXdZc2c4RWtnUFM5ZTFY?=
 =?iso-2022-jp?B?bE9sWVlldlVEQThhN25HeDRjMUsvSWVOVklvcmY1b21rR0pxVHVJWC8z?=
 =?iso-2022-jp?B?YWVwbWRWb3E5dG9SN1c2TEtCZUFJbzQ1cDdkWlRUMlUyOVRVZWZGRDFK?=
 =?iso-2022-jp?B?ZFFGandOS2JjZGFVUkdhOUVCTm5EYzg2Y1liMnRqbEdhRkZKaGY1cGxL?=
 =?iso-2022-jp?B?aG5Id0RZM1UzMUF3ZEVVMzRDNTFIakN1Y1hzU3had0pVWnhMek1yUGZs?=
 =?iso-2022-jp?B?THNFaUl0VlRVRldseUNSSmxQbHk4K1gyTUVQckJLZmplL1J2NGhDY0Z6?=
 =?iso-2022-jp?B?STNxVlZsTkFaNVVZM2xEa0p4T28zejlRZmdJa2NLS05xVFhyN2R3UEtK?=
 =?iso-2022-jp?B?bHRJWlBmVmlHcEFHa1h0SlNuODBGWXhyNm1vZUxyR2ZMbWUycWZ5WE9V?=
 =?iso-2022-jp?B?cWRWeDhiZnBRT0NuRGNpUzludUl1eitxT011d2V5Z2RHRUpsbFltbXhj?=
 =?iso-2022-jp?B?SHFhNzBXTXA0N1FNMGw2dmdMZWh0THY4clBJbUNiSTd1K2Q4WkZ6Rjcx?=
 =?iso-2022-jp?B?NDJXR3VoUHZCdGg1R01EWmYzL1NxSnVMNXZ0aU1WRS8wTWlGRm1TOXNI?=
 =?iso-2022-jp?B?d1ZnY2RMRmpoNE9nMXQ1NXJtdWkrbElzNzBoanVxczduSXNTT3ZFWGJR?=
 =?iso-2022-jp?B?QlBaaGxGK2VyTFV4UW1YV2V5VWlOcUs3WUIwTHNKQ3dwTU1UK3NPQ2hM?=
 =?iso-2022-jp?B?b09pN2hFd2F4dTZSdUlYejFpZ09RY0pwYzRFWnhhVHNYTlFBb1hXcERx?=
 =?iso-2022-jp?B?TDFuekxMdStTQk5LdWFRa2VVcGYzVFJteWhLVVVMNjB4V0U3dStuQ29V?=
 =?iso-2022-jp?B?SlBlOXZRYUJROXRkTDRqbUNoSFZqaldCZllkVG1HMXdUenFYWXBURVhK?=
 =?iso-2022-jp?B?bVVqK0MrakY3RE9Cb29ubzJaSllKekI0THlEOUNVOUQ2ZEJYVDFQSmh4?=
 =?iso-2022-jp?B?ZWlsMU5YTjFkWHZxQlBIOGtyUFFWczg0R1ZvbGc1Vk1ndGNwdVNxR1U4?=
 =?iso-2022-jp?B?aG95S2p4dVRpSlFvL1NGYnFhN29UcnNRM0RXNUNkVGVWeHpFYnBheU51?=
 =?iso-2022-jp?B?Zy8xMCtJOWc3eFBINGxYcGIyWTRURWQyK0lCZm9YYXRIL2hFTWIxeEM5?=
 =?iso-2022-jp?B?YXhvWmUxZTZ5NFpLUm1EZHd0L2l5aGkrZlhhYXdPTjVCYVp1NG5jYmpw?=
 =?iso-2022-jp?B?alFyeTdzd2VDMWJlclI2OU1VditIR2JDTWJPK1luWnZ3VTJYTEszRDJP?=
 =?iso-2022-jp?B?U3RXNVhwZ1pzWmtZY1RpT0tDbVNweC9TU09zaW1iUCtEUjZMNjNsUFNo?=
 =?iso-2022-jp?B?VDdqLzFJSHAwekxpb2pNTmordHBKN0dSa1NvcmZtWnM5MEs5aW52Rloz?=
 =?iso-2022-jp?B?ZVRaUlhHbUxTT1NDcUszajhNdGhhb2JWSTRhVk1RUGpFY1hUaVVlWW02?=
 =?iso-2022-jp?B?TFJtTmV2N2s2OEVpakZRbCtlTk5pOVNYSyt5SGhucFNaaWxkUUlSYzFG?=
 =?iso-2022-jp?B?aFlONlBRPT0=?=
Content-Type: multipart/alternative;
	boundary="_000_OS0PR01MB6100E150797AAB51AD72A3B9C2352OS0PR01MB6100jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6100.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6315e2-00be-442a-0ce9-08dd12d2a039
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2024 13:09:59.6641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ujlIqIy8fxXomyKLiMRImnemBTb1mFhYDsh9qOma/WA+9yqXaWoWySHB758IhxXMdDc3uplbfPTuJdbXJbgA8ypjYcL3VUAQxStSXaUGsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13881
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Dec 2024 13:10:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17304

--_000_OS0PR01MB6100E150797AAB51AD72A3B9C2352OS0PR01MB6100jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Quirin,

Thanks for your help. We will go through https://github.com/siemens/mtda to=
 understand how this can be used with LAVA to flash and boot the WIC image.

As you said, the secure boot image can be booted on a device with "Secure b=
oot disabled" in the BIOS but we have a requirement to automate secure boot=
 testing as well, so we need to figure out if there is a way to configure B=
IOS through LAVA before booting the image.

 If there were multiple devices, then this could have been handled using ta=
gs where security image related testing can be directed to a certain device=
 with all secure boot related pre-configurations done in BIOS where as the =
non-secure images testing can be done on the other device.

We can start a discussion thread in lava-users mailing list to check the po=
ssibility to implement this.

Thanks and regards,
Sai Ashrith



________________________________
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on beha=
lf of Quirin Gylstorff via lists.cip-project.org <quirin.gylstorff=3Dsiemen=
s.com@lists.cip-project.org>
Sent: Wednesday, November 27, 2024 7:39 PM
To: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>; Chris.Pa=
terson2@renesas.com <Chris.Paterson2@renesas.com>
Cc: hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D=
#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>
Subject: Re: [cip-dev] Booting security image (.wic) on M-COM x86 in LAVA



On 11/27/24 12:07, sai.sathujoda via lists.cip-project.org wrote:
> Hello Chris,
>
> We are planning to run software update, secure boot verification and IEC
> layer tests on M-COM x86 device in CIP LAVA.  To achieve this we believe
> there are two main challenges.
>
> *Booting a disk image (.wic) on M-COM x86 in LAVA*
>
> We went through the existing job definitions running on CIP reference
> hardware on LAVA to re-use if any disk image is being booted on them but
> did not find any. In every job definition, the root file system tarball
> and kernel image are deployed separately to tftp. We are going through
> LAVA documentation to figure out proper method to boot   entire disk
> images on LAVA.
>
> Can you please provide your suggestions on how to do this, if you have an=
y ?
> Once we are able to boot a disk image, then next task is to boot a
> security image.
>


I would suggest that you check out https://github.com/siemens/mtda. This
provides
  the necessary tools to flash a device over USB/SD.

We would need to adjust the lab setup for this.

> *Configuration of BIOS settings on the device's firmware to boot a
> security image*
> *
> *
> Basically, CIP security image has secure boot feature enabled, so before
> booting such image there are some settings that need to be done in BIOS
> such as:
>
>  1.
>     Enabling secure boot option
>  2.
>     Adding secure boot keys in EFI storage.
>
> Only after these steps, a security image can be booted on M-COM x86
> hardware. I am mentioning these steps based on our current experience
> with local setup. But I am not sure how to achieve this on LAVA.

You don't need to enable secure boot for testing - an image with secure
boot will also boot on a device which has secure boot disabled as the
image does not check the state of secure boot.

Best regards

Quirin

> One idea is to pre-configure the above-mentioned settings in the device
> present in *lab-cip-siemens-prag *but in that case I believe health-
> checks and all other tests running on M-COM x86 can boot only secure
> images.
>
> Is there a way to change the bios settings through some arguments in the
> LAVA job definition ? If not, then can you please provide your opinion
> on the above-mentioned approach.
>
> Thanks and regards,
> Sai Ashrith (T S I P)
>
>
>
>
>
>
>


--_000_OS0PR01MB6100E150797AAB51AD72A3B9C2352OS0PR01MB6100jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hello Quirin,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks for your help. We will go through <a href=3D"https://github.com/siem=
ens/mtda" id=3D"LPlnk917037" class=3D"OWAAutoLink">
https://github.com/siemens/mtda</a>&nbsp;to understand how this can be used=
 with LAVA to flash and boot the WIC image.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
As you said, the secure boot image can be booted on a device with &quot;Sec=
ure boot disabled&quot; in the BIOS but we have a requirement to automate s=
ecure boot testing as well, so we need to figure out if there is a way to c=
onfigure BIOS through LAVA before booting
 the image.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;If there were multiple devices, then this could have been handled usi=
ng tags where security image related testing can be directed to a certain d=
evice with all secure boot related pre-configurations done in BIOS where as=
 the non-secure images testing can be
 done on the other device.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
We can start a discussion thread in lava-users mailing list to check the po=
ssibility to implement this.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks and regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Sai Ashrith</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> cip-dev@lists.cip-pro=
ject.org &lt;cip-dev@lists.cip-project.org&gt; on behalf of Quirin Gylstorf=
f via lists.cip-project.org &lt;quirin.gylstorff=3Dsiemens.com@lists.cip-pr=
oject.org&gt;<br>
<b>Sent:</b> Wednesday, November 27, 2024 7:39 PM<br>
<b>To:</b> cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project.org&=
gt;; Chris.Paterson2@renesas.com &lt;Chris.Paterson2@renesas.com&gt;<br>
<b>Cc:</b> hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =
=1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) &lt;kazuhiro3.hayashi@toshiba.co.jp&gt;=
<br>
<b>Subject:</b> Re: [cip-dev] Booting security image (.wic) on M-COM x86 in=
 LAVA</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText"><br>
<br>
On 11/27/24 12:07, sai.sathujoda via lists.cip-project.org wrote:<br>
&gt; Hello Chris,<br>
&gt; <br>
&gt; We are planning to run software update, secure boot verification and I=
EC <br>
&gt; layer tests on M-COM x86 device in CIP LAVA.&nbsp; To achieve this we =
believe <br>
&gt; there are two main challenges.<br>
&gt; <br>
&gt; *Booting a disk image (.wic) on M-COM x86 in LAVA*<br>
&gt; <br>
&gt; We went through the existing job definitions running on CIP reference =
<br>
&gt; hardware on LAVA to re-use if any disk image is being booted on them b=
ut <br>
&gt; did not find any. In every job definition, the root file system tarbal=
l <br>
&gt; and kernel image are deployed separately to tftp. We are going through=
 <br>
&gt; LAVA documentation to figure out proper method to boot&nbsp; &nbsp;ent=
ire disk <br>
&gt; images on LAVA.<br>
&gt; <br>
&gt; Can you please provide your suggestions on how to do this, if you have=
 any ?<br>
&gt; Once we are able to boot a disk image, then next task is to boot a <br=
>
&gt; security image.<br>
&gt;<br>
<br>
<br>
I would suggest that you check out <a href=3D"https://github.com/siemens/mt=
da" data-auth=3D"NotApplicable">
https://github.com/siemens/mtda</a>. This <br>
provides<br>
&nbsp; the necessary tools to flash a device over USB/SD.<br>
<br>
We would need to adjust the lab setup for this.<br>
<br>
&gt; *Configuration of BIOS settings on the device's firmware to boot a <br=
>
&gt; security image*<br>
&gt; *<br>
&gt; *<br>
&gt; Basically, CIP security image has secure boot feature enabled, so befo=
re <br>
&gt; booting such image there are some settings that need to be done in BIO=
S <br>
&gt; such as:<br>
&gt; <br>
&gt;&nbsp; 1.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; Enabling secure boot option<br>
&gt;&nbsp; 2.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; Adding secure boot keys in EFI storage.<br>
&gt; <br>
&gt; Only after these steps, a security image can be booted on M-COM x86 <b=
r>
&gt; hardware. I am mentioning these steps based on our current experience =
<br>
&gt; with local setup. But I am not sure how to achieve this on LAVA.<br>
<br>
You don't need to enable secure boot for testing - an image with secure <br=
>
boot will also boot on a device which has secure boot disabled as the <br>
image does not check the state of secure boot.<br>
<br>
Best regards<br>
<br>
Quirin<br>
<br>
&gt; One idea is to pre-configure the above-mentioned settings in the devic=
e <br>
&gt; present in *lab-cip-siemens-prag *but in that case I believe health- <=
br>
&gt; checks and all other tests running on M-COM x86 can boot only secure <=
br>
&gt; images.<br>
&gt; <br>
&gt; Is there a way to change the bios settings through some arguments in t=
he <br>
&gt; LAVA job definition ? If not, then can you please provide your opinion=
 <br>
&gt; on the above-mentioned approach.<br>
&gt; <br>
&gt; Thanks and regards,<br>
&gt; Sai Ashrith (T S I P)<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_OS0PR01MB6100E150797AAB51AD72A3B9C2352OS0PR01MB6100jpnp_--


