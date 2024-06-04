Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0964EC25B78
	for <webhook@archiver.kernel.org>; Tue,  4 Jun 2024 12:36:51 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.20349.1717504602403799258
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Jun 2024 05:36:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=HrAgGC6Y;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1717504594;x=1718714194;bh=EdiOcS69VEfA/lXY4DFTLPDVQ8ppdPBxijgjdyC
	avqU=;b=HrAgGC6YCxLGqrQ0ie0+BN1wf9fQgie1EqErcKUmKLWkSoXVPtGYTQw6OMX+rQive97Kr
	nrMXdNzHX4zLJiUZI8zPsU9ha9rr+ICjpzsDAdg3kopsd6C0f2wTm/KGJtZ9OElqSWXmLvxMPX/MH
	zCIWz0Td/e0lKalKpGqKqXnddKe0MWsGwaitxWfY1E68cf5ZbR9glxrBxYcYCU/F2g4FJwL7eCWAf
	iK5LuZ9OsD2aL2aqb5si/8p+axdIAYUSYZ6jJFmRU06+zQfT65CWHWFuBs6VlAnciHQjfqUf3+s80
	Q692XZivbDAth664+wHeuD5CyAz6tCh3LWSi4bqotg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 454CaXXD1775880; Tue, 4 Jun 2024 21:36:33 +0900
X-Iguazu-Qid: 2yAblVO8Ewbj6ShY8W
X-Iguazu-QSIG: v=2; s=0; t=1717504592; q=2yAblVO8Ewbj6ShY8W; m=GX5bVTa4EntjsprJAHcZXVBqnCI7aoeQdKUEy2lL288=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 454CaV573566188
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 4 Jun 2024 21:36:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVl8QLIOaRmIBTXLiUS+m+PgCSGTgXMulISdQKZl2hUwZJCUbanRyGQ4aE+wtbNlkjAnQj/8KUdMHQ/ajLt35WgF9Zf5dS3rAqC/IIfbRHuv2U4RwfEuuxPZfvYFcu7PZypM/Nh/yO/L7uGbotZGLaj57SAfW02D2p1OKAo9gQbMiLoVK++6WrdKrf9hHnZY92hKupzNFhC7eFq0FUkh9z1eV13Cj0fz6SydSEktAt4x1gcmFAPpjlzTEBfY9fpYiDADziyo66In9zy7z7lFHwGi0dU3gQHOW0mJy5/Qntu7VWaJdzIQ2bj7JTpiNCOh70GtZt0mZAuIoHCxFq3Seg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5e/4GXtwBUdlR1ySjVFs9rZmGW85nubW8a6B6DOsS24=;
 b=WS6Brs7/Wad7wfFUTSVldmI4TbfBuV5XgaO1sg7ZORxwVC/yCZvppimpvE1Gj0f5V0n3VAiDGS//I0sIw8fFkRkn63QkRyEImkK05TMWHA7VpitoYuPk3r4O6hNv4cPh43cJQeySIdtRsD6UDqMZ/ef0m1PHfmY5UN8JohJKLpDlsAcQRhUL0YQE3SWPeG0IkFYD9Eh9GBoOIQGboxErlOml5EOEU4zupMO9hkPj5wbjcts5wuL6KKu1QXgA6eRDVdYqwCWrCOmh6WIfRfwsn1on7vRqgdKB1HeYBAiNyHNHE39X4dgVooKXGTZr9u8TqIPsZk/t2squg5qWbDjRpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>
CC: <ch@denx.de>, <quirin.gylstorff@siemens.com>, <jan.kiszka@siemens.com>,
        <cip-dev@lists.cip-project.org>, <Chris.Paterson2@renesas.com>
Subject: RE: 6.1 plans (rt, ethernet merge) was Re: Siemens targets timing
 out?
Thread-Topic: 6.1 plans (rt, ethernet merge) was Re: Siemens targets timing
 out?
Thread-Index: AQHatmonD0mQUneNvkWaRwr0jGTxrLG3igPg
Date: Tue, 4 Jun 2024 12:36:29 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388A607000BCD75B187AEC092F82@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <ZkTwEKwobEIumswy@duo.ucw.cz>
 <TYWPR01MB11862A1D29648613FB34FD137B7F52@TYWPR01MB11862.jpnprd01.prod.outlook.com>
 <ZlDjWu5tzsNV4dqE@duo.ucw.cz>
 <OS0PR01MB6388374CDAD1095B2F98A9DD92F32@OS0PR01MB6388.jpnprd01.prod.outlook.com>
 <ZlhfLfL7fmsHShTx@duo.ucw.cz>
 <99f545b1-ee28-4a23-be6b-68999d8218c3@siemens.com>
 <1ca5451b-4929-406a-a985-570eb5562f34@siemens.com>
 <7dd2c3fc-7c37-4b1a-a996-3f600278cee5@denx.de> <Zl2X8iYxb0r/2rTk@duo.ucw.cz>
 <Zl7slaoXqCXjwf8I@duo.ucw.cz>
In-Reply-To: <Zl7slaoXqCXjwf8I@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYCPR01MB11237:EE_
x-ms-office365-filtering-correlation-id: 802be5ec-0b76-4cf8-6fc8-08dc8492f537
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|1800799015|376005|366007|38070700009|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?Q3g4K0pqblA4b0NxOUxuOGFLN29kM2dFR21hT2JURTRoQitjeG56cjA0?=
 =?iso-2022-jp?B?eWkwS0krRElncUtZaHBuS3B2NSs0eVF3VkhEQSs4MTB4VTM3STl5MUFS?=
 =?iso-2022-jp?B?MXVudXdadzdkanh1YVdoV0hkM3htUmZGZFVvN0VYWkJWU3J1Z3Q1QkFR?=
 =?iso-2022-jp?B?K2xOaS9ZYjY0d2laTTczTzR5TmRhdFlVY0ZramdVS01SU0JTVkRMVytZ?=
 =?iso-2022-jp?B?Tk1NSVNtMTZPNkxHTzcvbENvQ1MxbmNqZVR4YkxLVm5ucVJMb1BiTG9I?=
 =?iso-2022-jp?B?NHRCSlFmS1N5bzZPS3VpNk54RDVEZE0vckJQMGlmQzBoeFVHZElCNlVU?=
 =?iso-2022-jp?B?MThxdDhjSVNzTElSZmtiVjVNQ0ZwcVZCekJTdzBFRTNrOUpxQ2N0bGpC?=
 =?iso-2022-jp?B?bzFXZGhjTThkNElMWEdlREpMTlFzQWt6aFFpOGI3VnNvZEJOL0RWV3M1?=
 =?iso-2022-jp?B?RWMxSFlUOXZKWTlTUEhkeWhTUGlOMGVTZFNIdlh4aWhGRmVMSXdMR2Rp?=
 =?iso-2022-jp?B?QjZvM3dKRlJmUTBoaGdHeFphaTJWK1grNkdzQUdPelRkWjBPZHBDRHkx?=
 =?iso-2022-jp?B?Snd6c0tXMkRRNFlNTGdwZ05OYmRGZGVXOXViUTVGSkQzNjE0WGZoZmFN?=
 =?iso-2022-jp?B?N1NaL2p5b1hnZVoxRGZQazdldE5qdEpmQXA0QW5taDBodWtJRkpkQXhG?=
 =?iso-2022-jp?B?bDVWTjNwclkxK21ONEFjMG9uNlFaa2lVTFIrN0dOeWxRTlZWZnMwNWN5?=
 =?iso-2022-jp?B?SzRwMFlVc2E4bDhGejZVN3dOa3p1Snh3U3dCRW9kc1BMbjQ2aUdSMUh0?=
 =?iso-2022-jp?B?dlBzeldWb3J6OVo0WUgzRUhRZy9CS2JyeWgyWEluUmVLRExmUEdHVEcz?=
 =?iso-2022-jp?B?bEtET1ZrZTEzSGZOUmJWZzlNYzZmcTd3RHpYM3VXM0FYdnVvcDdiNU5X?=
 =?iso-2022-jp?B?em4wUExJZzZCeVBzVW9sYjlTMk9sMml0WDVYa0ZEUldzOHJEN1V0dml6?=
 =?iso-2022-jp?B?NDJ4Q2lOM3Rqd1dRVDUxc0VIUU53ckdpZ1FzL1dWTWNyVEhJaVVmM1Fr?=
 =?iso-2022-jp?B?V1NYckdrNFF6R0s0N2czVElNblowUm1JdVVqeE9qSE5RTlVXaW5QcmdT?=
 =?iso-2022-jp?B?bFFxZjB6SVFlMFF1ZW9Ec2tCNHhQRWYvUURZYnZoZmF4ck1wOGM3bEFB?=
 =?iso-2022-jp?B?bHRPUWV0MS9mSk9mcmFFQUQ4UlU1VXBSdWZFQ0hxdmdGVytLam5xSjA3?=
 =?iso-2022-jp?B?bURpUFpmblNyVWpIQXlXSzYwYmdYNTUrb0VBSWEzN3RBbStWRDZteFh1?=
 =?iso-2022-jp?B?ZzNKUXFSRDdwQlEybGhkRVl3cCtjMjczdVV5TlBxRGdPSk9acElTUkkx?=
 =?iso-2022-jp?B?QXdDZTFRWkh3RENhS3JpZGNYbnV6VEJHeEdOUTBmb3BjYXNWYjV1Qnpv?=
 =?iso-2022-jp?B?VkJic0s4aXpRU25KR0JpR0xDdkc0RU5mSUU3eEg4VjdGL0xOY3NJQmtB?=
 =?iso-2022-jp?B?cHFIVE1xSFlXQmIwVEtocU1mWnNLc3paZ0Z5amxBM2hmQzV0QUlhVktq?=
 =?iso-2022-jp?B?a1hGL0o3K1JoRDltM285RHl0ajNOZGVSQnZZcEVwUExPYjNLNWN2WkZT?=
 =?iso-2022-jp?B?eFJ6RWNKVGVyTW8veXhQN2hBQmQvaUR2dnJwdXF2S3hYZ1Y4OEhTZ1JP?=
 =?iso-2022-jp?B?UjlnWlVoSGJ4YXVFZjZpZjJTZlJkbW52ZDRqUi85MjNuSXRMMW15MFls?=
 =?iso-2022-jp?B?M0sxSWdhN3RHa2R0UmZ2U2tKVkhScTY1VDYwdHNneVE0MHN4T1dMaFNS?=
 =?iso-2022-jp?B?ZzQzOHNjWUZSQzE0TFhjRVlodFNmUmdBSWhzNTVNL2tSa3BSOVZuTzVk?=
 =?iso-2022-jp?B?ZGRTNHkvcnd2aldCRzMvV1EyMzE2bXE0QXROekpBcVl0VHNYaWE1U21D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?VWNBZ25GRnBaSGtZZUF1L0NjRFd6RnpTSDY2T0trU0dCdW0xdDQ2UlBY?=
 =?iso-2022-jp?B?NEozdVhIOHlLOTlPWUhGc0tDbkd5bitrWFRmbFhPWC9ZeFdIcFQ4cjky?=
 =?iso-2022-jp?B?VFFVUzUxRjZSRHJrZktUc2hSZ3lQc3ZZS01jYytJcEc2amQ1ck9iV3Z1?=
 =?iso-2022-jp?B?bTBiM1JhTEJpb0NGbktlRUllak81SFRycmsxMDcvVVdNb3kyVkp6bTF1?=
 =?iso-2022-jp?B?cytIWVVwNHRjVU9kUTJDS211UjcvSlJQK1QrYTJrNU94d3FYcURqM2F4?=
 =?iso-2022-jp?B?VDdYNVZBanIyL2x5V2tUOURKdnIwYkN0ejZFRngxaXg0d2FIMWxkTVIv?=
 =?iso-2022-jp?B?djlmbTFYcEpBV3cwYTNrcS9kWDZTZHgyVm1EVTFCWDhaa05MVmp1S2Rj?=
 =?iso-2022-jp?B?czk3SmcrcVBDdE1HN2YrSGd0OUZ6TWxDZDVoK1N0MHZrcW1YMFpFN0ll?=
 =?iso-2022-jp?B?N21rSG9FNzlOcnpJTm50Ny9RekRta3RLdFBKeU1WeHJPWCsvS2lremdz?=
 =?iso-2022-jp?B?bmZ2U2hMdnYvSmhRVVRxODlZaGUweDF4K0lLUDArZ1VlOGFxU3JCeGU1?=
 =?iso-2022-jp?B?c1R0TWtmRUF4UU5SMkpwT1pHK3JEZHNRc2JLaWQ1V0FqTEdRcndhSVA0?=
 =?iso-2022-jp?B?bGNwTjAxbWlqTmlYVnJqWG9jODdpM3ZKZmRNaCtqdEFHenJmcU1oVVND?=
 =?iso-2022-jp?B?bXQ4UHNERWVMdVN5eVpnb0d3TFJKdkN4b1NYdjNuL2JyMzFwM2o4Mmk3?=
 =?iso-2022-jp?B?SCs5MjQ4WHkwWm1pQW1ranAyV2VXVVZWSlNpNkh3czVteE1rK3JvR0xn?=
 =?iso-2022-jp?B?aHFlNmJtWm4yd1Zob0tlcXZYNzN6a1cyelRYSTMxQ1JNK0dKMGhTakdK?=
 =?iso-2022-jp?B?K2F4K0lIazQ1TVBFbWduVlgrYkVLWHJYNEo4Q0xKb3FYL2tVem01VjJD?=
 =?iso-2022-jp?B?U1JGcERVeDJ6SkpXVEVxb0N4TGFxMGl3ZUNPK2tpdUgvTlA4NFhYOUhw?=
 =?iso-2022-jp?B?WHNLdThOdTY5MXJ3N1VjdjVVTnArQmY5V2JLNUpOTXg4VDF6RFBpY3hN?=
 =?iso-2022-jp?B?OXNJSy9seS8rZit0bitGNGZFckx1YkNuc1VyVXBRTWROdUxpZDV1cWty?=
 =?iso-2022-jp?B?V3k1ZXd1ZHJqRVpINHZVcFhCc2VGUDVPZTY3Sjd6c2ZqRFpGOUFTL3Z1?=
 =?iso-2022-jp?B?NDd3eFc0NjF5ZUpzVXM4K3VqbEM4QU9KY2ltejFxWG5UQ2N2Qkt4SWhm?=
 =?iso-2022-jp?B?SFh0U29zS3NDVmNtYjJLUVNXWURubmliUDdpWHVFdjM1dnpacStXQ0hO?=
 =?iso-2022-jp?B?Y3c4RnI1dVc0U1E3ZVNSTEhkT1ltckg0bm5VUmx6RkJQdkNsZHBjR1RD?=
 =?iso-2022-jp?B?ZERrdTQrdmJsK3JBQUZaNjYxdkhDeUJ4VlJKSmwyVFJZTTZKdWVKa2oz?=
 =?iso-2022-jp?B?WjFQcW82YTQrUWhuNVlQaHkwenM5TVE2Ny9jYVBRM3JXUHdEVzFtUEdm?=
 =?iso-2022-jp?B?M0Z0Z1RYL3hXWHpwbXNJOUUyZHhpS0d2U08vMjRvU2lRalk1YTZMNzJ2?=
 =?iso-2022-jp?B?STM1ZEgxcmpXTnBOTlVBdVg5cU44V0RobzU3S3V4WHF3QlZPMFduVkh2?=
 =?iso-2022-jp?B?NGNWRWVBc3JNNUpPWWFaUVlUSlJUOEFjeDhaODZDeEw3Y1phZ0V2UWxQ?=
 =?iso-2022-jp?B?dHlRVkhrUUtrMHg0czFvRndkdC9vcDFhK0lYbGdVQUhTZHBVaGJ6Qjlw?=
 =?iso-2022-jp?B?enpzTjR2cUFqVmxsYU03RFBXZU9TWHI3V2tCTEgydnRaYVIzU0RpM3E2?=
 =?iso-2022-jp?B?c3pTbzI5ZWthdXdkS0RielNUZzJ5SzVmdGlsenROUlk4K2xSeWVYcnpT?=
 =?iso-2022-jp?B?RVFPbVBBcnNIMDZ2UW56Y3Zrc281NjNUaFphWWpOdC9Iejljb1lqSGdw?=
 =?iso-2022-jp?B?RUlpbkxyMDR2YXNCZkFBbUhlSEpKVE5jUUdvWXc2TXhwN3FlZk9XZE10?=
 =?iso-2022-jp?B?YTlEYXZxOVU2aEJuc20zQ3RsT212QjF4VEplOGhPMFNXYzZaK0RpZkd6?=
 =?iso-2022-jp?B?ZThWaHRlTWw0YUdyaDY1SnRvUEJkWnZnK2hPL3Q3R1VMTkhPWjE2VzNi?=
 =?iso-2022-jp?B?ZVQ0bTlPd29nM3dYNU1FMTRBdUR0bWpkejJWNG01UGdoZ2ZIOURnSlVm?=
 =?iso-2022-jp?B?bFZiWkZRaS9VaU9NaFdITmtEanFBYW40MkRzTzBZYkZnMjZTbTFEY3R0?=
 =?iso-2022-jp?B?MkNJRUpvZ1BYOTJBMjNlSVlIcldCUXVTaHRuN1RkSVZ6alRncTh1VlpO?=
 =?iso-2022-jp?B?cXNnMXA2UFVYeHJPdzRZVHRINkVqY2lvakE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 802be5ec-0b76-4cf8-6fc8-08dc8492f537
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 12:36:29.3689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DoFLN/PaGhEIByjG7Um6ebdeNPuUgswS3Koh28CEP4o3qsJwRiI/YVYITGEVObxBq/ZSqv52iYoq9I3H9EbkcS4MJDByXdjUebgaruc9/Hvx75ug9reO91fTtciKdQBu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11237
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Jun 2024 12:36:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16105

Hi Pavel,

> > Thank you. Can you ping me when I should re-try the tests?
>=20
> Ok, not sure what to do here.
>=20
> So, 6.1-rt is due, and we have v6.1.91-cip21, v6.1.91-rt31,
> v6.1.91-rt31 and gitlab testing is broken.
>=20
> I guess Renesas Ethernet patches should not break Siemens boards, so I
> propose to apply them. Then I can ask for or do 6.1.92-cip release, to sy=
nc
> versions, and finally 6.1.92-cip-rt.
>=20
> If anyone is uncomfortable with the plan, let me know.

No problem to me.

>=20
> Iwamatsu-san, do you want to do 6.1.92-cip or can I do that?

Please go ahead. Thank you for your -cip-rt maintenance work.=1B$B!!=1B(B

Best regards,
  Nobuhiro=20

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Tuesday, June 4, 2024 7:30 PM
> To: Pavel Machek <pavel@denx.de>; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?=
.MN=1B(B =1B$B!{#D#I#T=1B(B
> =1B$B#C""#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: Claudius Heine <ch@denx.de>; Gylstorff Quirin
> <quirin.gylstorff@siemens.com>; Jan Kiszka <jan.kiszka@siemens.com>;
> cip-dev@lists.cip-project.org; Chris.Paterson2@renesas.com
> Subject: 6.1 plans (rt, ethernet merge) was Re: Siemens targets timing ou=
t?
>=20
> Hi!
>=20
> > > > https://lava.ciplatform.org/scheduler/worker/lab-cip-denx
> > >
> > > I had the bright idea to restart the server and update it beforehand
> > > last week, I now had to fix the boot issues, but it seems like
> > > docker-compose/docker now complains:
> > >
> > > ```
> > > docker-compose client version 1.22 is too old. Minimum supported API
> > > version is 1.24, please upgrade your client to a newer version ```
> > >
> > > It seems now that there is `docker-compose-plugin` package from the
> > > docker repos, which does not supply a `docker-compose` binary to the
> > > PATH. Instead now it is used via `docker compose`...
> > >
> > > So either patching all `docker-compose` calls to `docker compose`,
> > > adding `/usr/libexec/docker/cli-plugins/` to the search path, or
> > > creating a symlink for it.
> > >
> > > I will probably try to patch the `docker-compose` calls to `docker
> > > compose`.
> >
> > Thank you. Can you ping me when I should re-try the tests?
>=20
> Ok, not sure what to do here.
>=20
> So, 6.1-rt is due, and we have v6.1.91-cip21, v6.1.91-rt31,
> v6.1.91-rt31 and gitlab testing is broken.
>=20
> I guess Renesas Ethernet patches should not break Siemens boards, so I
> propose to apply them. Then I can ask for or do 6.1.92-cip release, to sy=
nc
> versions, and finally 6.1.92-cip-rt.
>=20
> If anyone is uncomfortable with the plan, let me know.
>=20
> Iwamatsu-san, do you want to do 6.1.92-cip or can I do that?
>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


