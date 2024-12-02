Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E142D49795
	for <webhook@archiver.kernel.org>; Mon,  2 Dec 2024 02:51:06 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.164835.1733107854584609460
 for <cip-dev@lists.cip-project.org>;
 Sun, 01 Dec 2024 18:50:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=kazuhiro3.hayashi@toshiba.co.jp header.s=key2.smx header.b=UFwLs7Lc;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=kazuhiro3.hayashi@toshiba.co.jp;s=
	key2.smx;t=1733107852;x=1734317452;bh=QBootV5i8ZZ/aSOeihb0xfSeLzO/VoYEQBsW6mF
	Cck8=;b=UFwLs7Lc26kd01rCuPulAXO6TWXITXJFKmqWothZCGHmjI9jiOrfv9Fpt0zdj7wj119v/
	/2gizL9gD4RmaiICqjFm/rD41RpoN8VZtxxHXOg4Bz+cDBxnl0ovvPSEXdmypVnvYokluhG7xKPBP
	9o8bmbWVbOmyeqS08xsi/o0xMK3onCk/MII+5Q8DeXzWGjwjzYm5RhNJdUjfvR17CBxSQceUKLqgK
	dVJPZBOKalo12NER6PW60p2+y/CIBuqXlQPLp/F/2dmRo3Cr5/hY+C0kZoKNH3oddxjdjmReY/Mli
	B66CoAt4Wvw4j9XofsR6z/WbaC2nqSPXL/KBFCBi5A==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 4B22opce2424594; Mon, 2 Dec 2024 11:50:52 +0900
X-Iguazu-Qid: 2yAaY9rKx8sXqTHF7G
X-Iguazu-QSIG: v=2; s=0; t=1733107851; q=2yAaY9rKx8sXqTHF7G; m=HxWfWisUQaa3us4qRZLdCrgzF2kRGLoK8I3WC8fayAQ=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 4B22ootY1268388
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 2 Dec 2024 11:50:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oXjWodFjNP6GGtgqWXUVN3GnvOK1btxNM3jiTM6xYnYRiDNGPrjsi2J3PIEyvtnrDMYlEc47FfuaDlSa5lvJUiyo1oJ2sNExd2s6mGPstymTQzoKIv3Jw6XPhMAle2mvi2ZJ5qdf5BnlYN2dUpJzTw/GspIEZQ5vd6Q6CSw0SPSWceY/QSsUwsNB7KkHu7VPaacevJ7wPRFaNRJjmwZwp9O/VjWastT+JNS1sVud594SdIPwT7O7sI3m09vpCJs4Frg6FJN1iMgpm2vlZ7kteUur+My4b9qLLFpcy+RF9by2fn1TcJknzXeZLvzEvWXKJ+rI4ouoKYKcVps105S4Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYcRIB2nrpekB59ZPcGd4ce9ktdrLlsE//TwRYSKdOY=;
 b=ayycOVv3gZxecDyUir3JqigKjKhJT9S1xiHMTDUm1SrYJY/cT0cUAHnEIxvrm+L2XecZBo6Jsw5iZKDUrCHPOT5qFEOPBqiGfjT6yIHDU9h0GAqybbQm4JU/ra6pfm9B7OSBQN76zVe3/Rz6BHIxq+mxlmFiexbpraxc0uwuoYwj/iRmIA3MUQbTP50WCfHgAh2/cLnVmq+zoXEv7y1sWhDt562CgKLfADdkGp7xK4Fvmlq+aLho+cahBZZo9r145/wkCELekRoVf1qLuublN+Dqdepo/rTlsW8z0ubj7zWQz86W2BVXIedvYakfQ4DTuzqcOtG8joUHtwf28PY9Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <kazuhiro3.hayashi@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [4.4.y-cip-rt][RFC] Repeated WARNINGs in
 unpin_current_cpu()
Thread-Topic: [cip-dev] [4.4.y-cip-rt][RFC] Repeated WARNINGs in
 unpin_current_cpu()
Thread-Index: 
 AdsJh4OWhCfjKTeTTpWNGegB8O3M+wKZptcAAyMC8oAGUKjG4AHAfXyAACXVkeAAPI+ogACE0nfA
Date: Mon, 2 Dec 2024 02:50:47 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB11385CBB6FF725E6FA81C9C50E1352@TYCPR01MB11385.jpnprd01.prod.outlook.com>
References: 
 <TYCPR01MB11385E3CDF05544B63F7EF9C1E1622@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <ZvvRQmpIm4UHHhGS@duo.ucw.cz> <17FF38206FDF8135.11625@lists.cip-project.org>
 <TYCPR01MB1138579CA7612B568BB880652E1272@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <Z0cBKfpz3I6pA4MW@duo.ucw.cz>
 <TYCPR01MB11385501FC495E0F4E531A749E1292@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <Z0mVe42i41SXemYu@duo.ucw.cz>
In-Reply-To: <Z0mVe42i41SXemYu@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11385:EE_|TYCPR01MB8439:EE_
x-ms-office365-filtering-correlation-id: f835d0b2-4d5d-45d8-5dd0-08dd127c1fbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?cmxRUllGMG5ka05DWEdHSUJrbGg4OW52UjRoT1VJQnZ5d0JSYzBVc296?=
 =?iso-2022-jp?B?OXlwdHN1ZzlQQzdadTBnZ2hqTGtJUEZJaVJzTTgybDVvSllYOUY5UEV1?=
 =?iso-2022-jp?B?dm8vd3RHdVA0UGlWMkRGbWFZZHo3dkphc3BFL0FSRUpHM3BtV3pkd1RH?=
 =?iso-2022-jp?B?UVlPZjI3NnlPZEQwOFRDa1NVeEpWMlFqT3VyYldaMEw3Ynhra0RPUmV4?=
 =?iso-2022-jp?B?RXczTVBwV0V2UVpGYU81MnlXR1dIN2owQ3VYZG54QXZtRGtaeDkxd3A1?=
 =?iso-2022-jp?B?SXp0UlRiUEU5ZDZId1VTd3hwZjBZWnNVam9mc2V5UWZkZndTYlBxUGMw?=
 =?iso-2022-jp?B?RWpMaUdOM2N0TVBRTlM1T21sNG1hU3d6dnJEVlY5UTU0bHBOZnZlV0ZD?=
 =?iso-2022-jp?B?Njk4MUlxd3VJMmtxa0dVVDhuanZheXRGR2xpcE1oSEtyTm5STDF6STBG?=
 =?iso-2022-jp?B?V2MrZTkydmxJNFp0bzhvMjBxNVdtVytRWGYxdDl2WjE2ODVkOUtXVS9K?=
 =?iso-2022-jp?B?OVdaS3NocGhxVVB0eWhqMlRVWjVOWUhVcHhKbWhidFVpWlcvY3lPZDJC?=
 =?iso-2022-jp?B?d2s1WTFUTmRRbUlKMC8vMXh0WE9xb1g3NE45bWFTQjIvRlg1ZmduZmxM?=
 =?iso-2022-jp?B?Z3lXeTNCeWVMYkZORjRFRTR0QmlHdmZXRnR2cXdUaHJzZmloa0k2Q0pX?=
 =?iso-2022-jp?B?bWlkTG9RQTdZRWhnd2RwbW1LVlJ2b3dPYjIxL3ZubUhEYy8yNkJOTHNk?=
 =?iso-2022-jp?B?bHhxc0M1NXRLQ084QTNQdjdMSlFPVFQxY2VoVDZ6a3lQanpWSGsrKzBa?=
 =?iso-2022-jp?B?b0Q1cGMrbi9lZDluRkN3WnRpNkZraGNwUjJYUjEybnJwTFhNSGw2TGk4?=
 =?iso-2022-jp?B?WXIvaUVnL2FRRVo4eHJPcTBDaFR6a3hlVDk1ODc4T2ZVa09aZVBQUEhR?=
 =?iso-2022-jp?B?dzhHTVhYWGRQZ0VVa3dVS2cwYUk1NFJkMFVNSkxyUm5lcWZEUzYrQmtx?=
 =?iso-2022-jp?B?ZW53TktBdmwvL1dzeWl3MzZzYnBScWxRSmxwenBGNEpPN3R0WFlOdFNk?=
 =?iso-2022-jp?B?aHdNZlZEOWlBaENqMFliUnpyL0lnQVpoSkJENGNyd1N4REVFK3IxNFcr?=
 =?iso-2022-jp?B?cjNjUlVGQ3I2WEZOQ09DTDdINS85WUMveWdDbDhwVHhRbDJHcytxRHZq?=
 =?iso-2022-jp?B?MzVNdXRFb2QvRmFPR2ZnT3lGSUZZVmJxTHlzTWRnV3hDUzVITWRoVm5F?=
 =?iso-2022-jp?B?WHQvRG54MW9hTElKbTFza1JReklKUk85bzV5V0owanNwclJLRzJFWEtK?=
 =?iso-2022-jp?B?cm9DT2dwUDRZdkExZFA3cVpyNGFrMzljdkh1WEFISUdUK3NRczM2OHlm?=
 =?iso-2022-jp?B?QmQ4WUZnR29tTy9jZEZ3cUpXZy9sNFhnYm85VWZNSVBTWmJRdGJjSkh0?=
 =?iso-2022-jp?B?MHAwVGF6d3kzcmJrSklvdTYrWG9LR2IyS0F0OVVPU05heStNa1BMaVZT?=
 =?iso-2022-jp?B?bDFrdy9sV0RITXZPaFZSOXRtSHFUU3RUOERsak9LVTlMczR1Wmtzb0g4?=
 =?iso-2022-jp?B?R2x1Znppd3l0Zy9aQ3JXN1N6dGUycGpnbCtKNG1vVk5ZamJLNVRGazlS?=
 =?iso-2022-jp?B?VmFvT0NPR0Jtb0RnejZlWktoakIyNHRZWlBEeFdNZW1RZWlrRG1DVFR2?=
 =?iso-2022-jp?B?RGE5b01BaysxaGtUS3l6enNYY2NPNFd1bHRGWit5ZXoyMlRNellRLzRv?=
 =?iso-2022-jp?B?UEN2a2Vva3NWK2duSkNFbG9uSUZZdS9qY3g2WUE0K0xKUUR5RGZ2aUlU?=
 =?iso-2022-jp?B?U2VJUFhPZ3VlR0UwRGw1bmRJcmNEdHhBMk5QNEluSnA5YVJrMzBIQ1Y1?=
 =?iso-2022-jp?B?SUhYaThDVm5lYUtzaWhjSU5BUWtCQnBPR3FnWUNlVDV1dVZTWnFVU24v?=
 =?iso-2022-jp?B?WnBqMTlyRk8wMTB4cjNPNWozN3pabktmWTlTT2dKZUVyT2tVTHJIVFIw?=
 =?iso-2022-jp?B?QTI5U3V3Rno3SmdyKzRrV2VkYjlFWUZTQmEyNyt5T3ovYjlsVCtQWURU?=
 =?iso-2022-jp?B?alJOU3Q2NkFqQTE2Sy9qQ0kyNkNrTTZqaVlUZnd1QWJuNUZmdWlYZjRJ?=
 =?iso-2022-jp?B?a1I=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11385.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?R0pBS2FTaTU0bnU2bjRYM1Bwdmd2eUtGN3MrMUNaWEg3QkI0N2o3R25X?=
 =?iso-2022-jp?B?QXBkU2w3YWtDa2toaERtNEpkaUZqaUdRNENkdmFUclJpYVJPSmhTRkpj?=
 =?iso-2022-jp?B?SDVFYmNMVlRteGRQOXl3VksrL0tmdU9nUkVRR1lpYTJ2R3p5cGV4eEs4?=
 =?iso-2022-jp?B?WnVvbzJtRDk4T29ITVVFSGdDNVdiVklZbW00aHE2azdaN3ZwOUFCYTdr?=
 =?iso-2022-jp?B?cHVTMkRWYVVZdVNRK25EWTE0a3hrSkp2V0ZpTHljNzA5TmVuRXhOSGkv?=
 =?iso-2022-jp?B?WUFZVnFpbmh1WXNYaWw5RGxFUjNvSGJxbGZEQVIwWjF1eXB5MU5KdHJ3?=
 =?iso-2022-jp?B?dFZTdnVzRURzY0JTNCtQb2pMUUdQV0pwV1Y0NHNYRkw4UW90N1pGMmJW?=
 =?iso-2022-jp?B?cm5OMkJEd0FLNTRzTkZIOXJQNk9CNDJadFYxdFdkK0IrVGpjNEdONG5t?=
 =?iso-2022-jp?B?NHVSa1MzQkFzQVVuWmxJWlJVUGp6RmtzekpjZG1TMm9FK09pQXV1NVFk?=
 =?iso-2022-jp?B?UUVZWWZjSnlZOXdZRDM2Z05lZ1BOV2dMdytsWWxVUU1NaWduSXM0Rk5C?=
 =?iso-2022-jp?B?Rmk5b3Zlbzd0UTNVMEtyclRoOTJ4c254bWJjZUFQYkZFSHdXc3lLcHg3?=
 =?iso-2022-jp?B?TmtrZms3eGk1c0dQMmZyVmJkR2tZdW9wRXhwWjlzTVRPSUp1RVVUNFhK?=
 =?iso-2022-jp?B?YnZORWdhWmh2TmN0UTMwbVpYTS9EVnJRTVZGc0YzSGFaRnFmOFEzcFZk?=
 =?iso-2022-jp?B?cFNxYkMzSXZDaE1GdXBmdk5zTG5GTVM1Q3FQNGYyOXdRTzJDZWJLMWhT?=
 =?iso-2022-jp?B?bG8wbDI0QXBYczQ5TWtJdzcyYURwVHV5eCs1YVBsd3dYaENlYlVXN3dn?=
 =?iso-2022-jp?B?UjU1OS8xWDhoQ1puYnJQOVBwM292WDQ4THpjSUZnTXkxM0dzK0dDRTNL?=
 =?iso-2022-jp?B?amxidHQzSmcrRWU2QjBaMVEvZ2l5aS9sNTg5VG1jQW5Ja20yVkxsZXhZ?=
 =?iso-2022-jp?B?aDlUd01LUlNmTXBPSjBhMnBrTzM3ZHRyTk1zY3NObDZLSm5FbnZhZThm?=
 =?iso-2022-jp?B?TVg5dXZSQUFvbDJrNUR1VnNsYWJwcVNuOVdtV3Bhb2xXbFNvbmtIK0Vy?=
 =?iso-2022-jp?B?cVRCUHhoZ3JkMmZvQ0w0dHlGK3Qzd21kYjllNy9vRmNGV2xhU2M1QUJY?=
 =?iso-2022-jp?B?UTJ4Ykw4RTJlb3VjZllZckJ2QzRZeEpROW9XWi9Hb2ZGNFVTRUxFSWhp?=
 =?iso-2022-jp?B?ckM0amVzcExHNjB1TGNWY2VSVDVvN0VISTNEVExnemlSaW1GYXY2UU9M?=
 =?iso-2022-jp?B?RDhBK0ZmTlRURlc5ZHdxYWRIQXZyYWt2ZVBjZThVMmF2TXpISmdkZlhD?=
 =?iso-2022-jp?B?TVkzZVdaS1ZLcktkRHZaQUo5YXhselFMLzBDeVR6WEhEWWdNUzJIRU1D?=
 =?iso-2022-jp?B?K3dwYmRRTEZpRGJ6bGM0aXZPV3Z6VGFjckdYeFdtdVNFeVZMeC9rL2xG?=
 =?iso-2022-jp?B?Vkp4eHN2WkJwdzJ2VXBYNVBMZlhvZk1hdmNjcEFya3FaaHFJOTloQUNs?=
 =?iso-2022-jp?B?OGh3bTFIY2pKREljMElQT1Z0TmVFZVNWYm5INlZPY2ZYNzh5cENyUmJ1?=
 =?iso-2022-jp?B?VFJtMHp0SElQUURzK2dBdkVOTjFqRHYwcE9jQXVPa1FqNENmM04xOTJs?=
 =?iso-2022-jp?B?YXN0NmNuSVVPZ21UTEZsTWtqTVhKZWhkZVhDU0tydlBmQllZZXNSNmhQ?=
 =?iso-2022-jp?B?THNzalJPME1BVG9JV2pqYmZhTEVZOU5tcFBXRmxHTzJ0ejM5ZTNPWDZl?=
 =?iso-2022-jp?B?MDVsYzE3U3NMT1lhSCtwWGQ3by9pVllqZDRycmFYazd4b2Nzc0RIbXFs?=
 =?iso-2022-jp?B?UTg2cnFmZUhDSk5NNnpBNXYzbDdWL3N5bEtUU0Nsa1hQcXRPeHRSUFBT?=
 =?iso-2022-jp?B?S1ZXT2F5Vm9FWXFGR1lXZTRIYWhGbTVGSUdyQ0lUUkVEVnhNYXlsQ054?=
 =?iso-2022-jp?B?eW13eGZHZnUxOXR6QlFzS3J0RFQ4RGNEUjI1Y2pTR1JlYkRENi9JNzBF?=
 =?iso-2022-jp?B?UGxud0hlVDYxTy83V0h1WkNYOVJZc2FDQk01SGpVR21jNVRsRUo5b2oz?=
 =?iso-2022-jp?B?MHRiL0VjYUVNbXFid01tVlJYRTVCV2lLTTJzeGQ5ZUlMVWkzK3o5OG9Q?=
 =?iso-2022-jp?B?ZFY0UmVPeFZ2UjRRczRZQ3Z5bVhqZkh3Q1Y3aXZ5RXJwMnNLY0FyNTda?=
 =?iso-2022-jp?B?Q2FnbWlyUE9TSlhZaUxIeGhYM3lVaGNLWVNOM1gvOXFTWlRvWnNoNFQr?=
 =?iso-2022-jp?B?cUdMNGtFVk9jZElObDNrQzh3M1NkTjRSU1E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f835d0b2-4d5d-45d8-5dd0-08dd127c1fbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2024 02:50:47.4025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s7ckfAKKFXczs7BeQEL5tSIk6lPwAmDjqD2iI+9Zu3gu8rwweVTV4SDhbHYrsWFUu6RVQDKA0CogselhYWQUoqdSSDCWxv9y/wRn+FzAVnvsuhDbs2ZUYfG++AUdFosX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8439
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Dec 2024 02:51:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17303

Hi,

> > Please note that only one patch ef284f5ca5f1 (3/17) [1] for arm64 is no=
t
> > included yet because it would take a bit longer to check its dependency=
.
> > Also, note that "2_allocate-slab" is also required to backport but it's=
 not
> > a part of the might_sleep() patch series.
> >
> > You can see the most patches (14/17) are just to adjust system_state ch=
ecks in
> > existing codes accordingly to the newly introduced SYSTEM_SCHDULEING.
> > Core parts of the series are:
> > * [01/17] init: Pin init task to boot cpu initially [2]
> > * [16/17] init: Introduce SYSTEM_SCHEDULING state [3]
> > * [17/17] sched: Enable might_sleep() and smp_processor_id() checks ear=
ly [4]
>=20
> Agreed. And only 1/17 is really fixing things up, right?

No. Applying 1/17 is not sufficient.
In order to avoid the WARNING, which is system crash actually, No.16 and 17=
 are mandatory.
Strictly, the following parts are required to make another patch
"2_allocate-slab/0016-mm-slub-allocate_slab-enables-IRQ-earlier.patch" mean=
ingful.

[16/17]
extern enum system_states {
 	SYSTEM_BOOTING,
+	SYSTEM_SCHEDULING,
 	SYSTEM_RUNNING,

[17/17] rest_init():
+	system_state =3D SYSTEM_SCHEDULING;
+
 	complete(&kthreadd_done);

In short, SYSTEM_SCHEDULING is mandatory to add as long as we try to
take v4.14-rt based implementation.

> Others are
> really only better diagnostics / enabling checks early. If 1/17 is
> enough to fix your WARNING in 4.4-rt, we can certainly take that.

IIUC, the patch series provides the following changes:

* (A) Fix smp_processor_id() problem =3D> No.1
* (B) Introduce SYSTEM_SCHEDULING =3D> No.16 & 17
* (C) Make debug_smp_processor_id() and __this_cpu_preempt_check()
  available earlier (from SYSTEM_SCHEDULING) =3D> No.17
* (D) Make might_sleep() available earlier (from SYSTEM_SCHEDULING) =3D> No=
.17
* (E) system_state adjustments for SYSTEM_SCHEDULING =3D> No.2-15

Here are two problems to resolve:

* (P1) smp_processor_id() : See No.1 commit message
  * This is not the one I reported in this thread, but also present
* (P2) Repeated WARNINGs

(P1) can be resolved by the change (A).
(P2) can be avoided by (B) and "2_allocate-slab/0016-mm-slub-allocate_slab-=
enables-IRQ-earlier.patch"
If (B) is applied, (E) should be applied too.
(C) and (D) are not required to fix the problems, but they are already a pa=
rt of No.17.
As the results, all the 16 patches should be applied to handle the both pro=
blems.

Is it feasible to add "SYSTEM_SCHEDULING"?
My understanding is that (P2) should be present not only in my environment =
but also
any other v4.4-rt based systems (i.e. system can randomly & rarely hang whi=
le kernel booting)
and thus should be fixed/avoided anyway.

Best regards,
Kazu


