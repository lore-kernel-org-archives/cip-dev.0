Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A867C27C4F
	for <webhook@archiver.kernel.org>; Wed, 26 Jun 2024 11:11:49 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.23508.1719400301810623723
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Jun 2024 04:11:42 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 45QBBdLi2388320; Wed, 26 Jun 2024 20:11:39 +0900
X-Iguazu-Qid: 2yAbXhlxPOKrvVK16O
X-Iguazu-QSIG: v=2; s=0; t=1719400299; q=2yAbXhlxPOKrvVK16O; m=wJ3ibLUR1ZRwXr2cE1mjMIalD0YK4GabjyhHzdiHekc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 45QBBcAY385156
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 20:11:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2b/yNnqaRziJc3ysEVms+qNUoEIRpRU9qEUJFvqXGhoRS2JiqCZkccum5wzRgAIdcNFaxiUAn3RnnWZZ3kb/6gNbePvXeaPZzXyz99dGWaSfAdywiBd1kS7Ftm04LQtlCorWqspzpx/yws/zMhbnjqaRKpcvKq9VaM2shpY38s6CvreQS78+doxNCj90IXuY5nJTnEocP4zPQseZva5V4forE8pL5Hdn67ZKQrJO7HmflRkLIditAkZVHxXlAqI9EhE7lnTQamQzpAEbwGHiBkVTEuboKj9GEa/MuEYcmQEqmwyULmLR4f5WvPwmdLLAa6w2zNgB07XKJOovDZTyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrAAU8yKARdP02W2fK81NtrzPgbo+n3byjSRSrwT5RI=;
 b=GXNLHH8T4EvxDRuWOVCVJxc5M23XVdw+79zStd3P1jMkOuvh++qaie1GyugGznY+uzapw/BqxkJ6uvQvFF7/Dl4D9BbmwbkCoR0e0tVaSZgMbl5UUNUvxMZAgAIguuKiUM9YdxTTD1gmzG9b/tnxabwrxbJOUDqW1aytbbuYJBUR2uJOBIR5PdTaZEkDXIopT0TuYbMIVtJj1LpM8oSxfoUHUwW6yVz0n7BtoMDsGcCBF3SM8zA4YKpZWf2P7fQX2MVzRH/+3rxxeV04aYuFKoTuUhAjmwZz5e8OgBtN9ff6kSgZIF9NuPzgC6svrJ6as2PUvzxccvPPcceay7bySA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <Shivanand.Kunijadar@toshiba-tsip.com>,
        <Sai.Sathujoda@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <christian.storm@siemens.com>
Subject: RE: [cip-dev] Regarding support for WFX backend for software updates
 in CIP Images
Thread-Topic: [cip-dev] Regarding support for WFX backend for software updates
 in CIP Images
Thread-Index: AdrC1ksCFU48h0ptQR+cT3Q7rfn9dAALvlaAASzk5ZA=
Date: Wed, 26 Jun 2024 11:11:36 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB96699CA603391978B206A54BC4D62@TYCPR01MB9669.jpnprd01.prod.outlook.com>
References: 
 <TYCPR01MB9669288BB5107DAC76CE3DF7C4C82@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <561f6fd4-a66f-40a3-adb4-b94eb2c35ce0@siemens.com>
In-Reply-To: <561f6fd4-a66f-40a3-adb4-b94eb2c35ce0@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|OSZPR01MB9613:EE_
x-ms-office365-filtering-correlation-id: 7c7c55e1-626c-4fd4-8497-08dc95d0beab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|366014|376012|1800799022|38070700016;
x-microsoft-antispam-message-info: 
 =?utf-8?B?ODI5OTZacCt3c0tERHJneHJSYVdlN25uVnBhWjAwT3JmbkJLbGlLNHVET0li?=
 =?utf-8?B?bWQxdzFySlh2dks1QmIwZi9xUXY3OEw5Ym8xTk9aemJvaE1vYUV0a2JTSzds?=
 =?utf-8?B?bzRuVXNXbzdnUFdPTkJTb1BHNENDRUVsWjhBODBYOU95RUx1OUFoQlRWdjM3?=
 =?utf-8?B?Z2ZsVm8yR0lTajZlWksxa1Z6eGdJbzZHOTlkSC8vMGF4cjN2UDV2cDlCY0dJ?=
 =?utf-8?B?QUpkSTNBc1hpWUt5a0RZTmJ4a0IvNTY3blJ5VkhabEIxdEJPcHg0Nkp6OEZM?=
 =?utf-8?B?ZXUwTFFXU2RrOThGVlJyZlkxRXJlMW1ROU5FYUNURzRKUkViRTBySU9wdGZ6?=
 =?utf-8?B?TlBOdURRak9QaWR3SWh2alduSmk1alp3eC9GM0xOWU5wWTQyVFpwK2RvaXZz?=
 =?utf-8?B?RTlaSzVFTUoxSGFWRUFmWEZNSzl3K001QTdZVmx0ck5HeGRmNFBCMWJHc3Y4?=
 =?utf-8?B?MFp6M0R4dDdGOTl1U2kvbVJIaEd6dVh6Y0NpK2hhcGVidmlISkNUUlRoYUZC?=
 =?utf-8?B?R3BKbVJlcjNac1dVcDFjVzhjV3dsL0M0TDlBM25haEoyNWdqZk1zZ3NHV0lS?=
 =?utf-8?B?M0p1TjVCUmord21HcThRYWNPelZkUkZBOVZlSm0vVG9wWEkxQkZyeTd5MTI4?=
 =?utf-8?B?M0hXcFJkMzY2dlpQQkFNWTZzOUw2cm4vQS9IMlBlN1Z4dlJvTEtuN3lpTVFD?=
 =?utf-8?B?ejExelJFK3c5MmFhOU8zdTVFb3RsRkh6cCtaQlc1TnFna2puemVZYlRSN1ZZ?=
 =?utf-8?B?bmJ2YTZMQWJHN2pVa0lRWFVOMHVRd1hTVSt2NGFLdnhoV2hpY29rUDA2ZTFL?=
 =?utf-8?B?bFhLZmFZdEJiYW9TbFFxUlkvUzR5eGNhbm5tWkl1L1VQWGlaTHFKbzM3WXdL?=
 =?utf-8?B?eDlHNXh5ZEQwZ1ZZdlNBdFkrNmpqNm5ISVBCMnRHWkVsSHlsNjYxaG5XQmV4?=
 =?utf-8?B?Y1hJRlQ4VDBOWkxqVlg0Z3c5K1dTelYycWtlbnRPbHJKTXVrR3B6RDNGTWMy?=
 =?utf-8?B?a1I5RmZBSmc1dFptczZGTXlWTWU0bDNoN2RncmRNNE91eVNaMEV2a2RZTHUw?=
 =?utf-8?B?SE1IYU9aSG12V2F1eDlOYjVWT3hKNDJNUUtNeUhXMTBrUndHamUwcjB5T3ky?=
 =?utf-8?B?bG1IcTY2SUdmK3RBUHRJelFSYXc1UUpvUENBc1VkcU42ZWlMY0RnczNUZnF0?=
 =?utf-8?B?akVkQ3d1bVVCZWltT2tvbFIzRWY5MlZ3eVFUSE9lNllLSWd1WlZkNFFmSGpI?=
 =?utf-8?B?RFFqdnczd1lHZHhMY0R3bTA1YjlGSlIvZS9ySk5IcUZpbE9QTHBNdnF0bkt3?=
 =?utf-8?B?TUJUOHVNMndYZEYwZi90MzlDeERuajNaVmZGWGQwMklMUDJLSzJDMjhLMHA0?=
 =?utf-8?B?SkxFakZ2OWh6cDArUllianRhUmdYMGdwLzUyVi9YRUJNNzd3RkVzNWswYmRV?=
 =?utf-8?B?enkyMEVTcTVEeDlGd3Y5eUozNVZTdU1RaXdsbVZVK0Jyc0tvVXJTcjZBUVhM?=
 =?utf-8?B?T0dMQ1hPeENFRlN2cnVpaG9OUFNjTEJzUlpGZFQ1RkN3ZGVFMUxWNDY1K1Rw?=
 =?utf-8?B?R0ptdE0waGp3S21LOVhUa2VnNXorTEhOVWZaT0MwQ3dSYlFQcGxCZFhoYjUr?=
 =?utf-8?B?dElsUVVObXdOMkxRVEpzeVRZU0M1QlB3ZVdyWEtZemNUMUxqMUJFcjZLNVFw?=
 =?utf-8?B?cVVTMEYzWVN4S0xRdUdQNXhOc3ZoOFhMbG92TFZJWUM5bitSZEhxWEdERmxr?=
 =?utf-8?B?RzJ4T01USVNSQ0FQN2pKdEhUMTg0eU5QT2Z6VmpyRVd5QjlxTVBmVzRkQUFB?=
 =?utf-8?B?RmF4ZUtINWpQOWpabnVqbGRUSmk2SFBTdlVCS2RETkp4RFZ1MCt5UFlwY0VZ?=
 =?utf-8?B?ekE2QVU1QlpRQnB2V2Iwc2cxYzJZNVhqNTZyU0NFWnpIYkE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UGpwQkJETmFKRU8zbHlUSEVOTzY3RkdWMnBNbDNZMmxwTXdHVjZPSDZyVVht?=
 =?utf-8?B?L1I3MmloNWk2RU4xMlJWVXk2bGxmMWtQMmJHelcwVXg1TjM1WlBsempKb1Qw?=
 =?utf-8?B?eUxWMXBnTFhkeG94UjllVVJaRzFJL0c2OGRueWRYa3pua1JCMGlScitMbjYz?=
 =?utf-8?B?RDY2OUE1RU1lbzF4eWJUa0kyZXhqVSs0MEsxcENzUjZ3Mk9UMWU1NndnZUIy?=
 =?utf-8?B?OFFHWFZKOEl6ejd0ZVJtanR4ZjNoQTQzd1U4ZWNRRkZVa3RWYnAxbnVBcE5I?=
 =?utf-8?B?U1lGZC9tSW01YVNIdWM3K3Nuakpoem5OTklxT281Y0kyNEwwMnlKY1dLbmRk?=
 =?utf-8?B?dmVBeVowbmljMDFyWlhDcUNHVWhTUDhyZEVqMXcwR2NXYU5XSjdoeStXaDFj?=
 =?utf-8?B?UE5kdlIraW9Ba1pDYjN3YjJxYXJXWDFOR0tFc3BKS2hwSEFTWWdDeWhSbzNS?=
 =?utf-8?B?SzBjUm5wTjZZMVBlSHhnSFc4SFdLMGJwclBHTUhmRmVPcjhiaUJoYlB6SEt1?=
 =?utf-8?B?T3dIQ1RPUWlXWmhjNHBLVlpqUnlLdG5ZbnowRkFQTDB1Z080bElaMXFsNlZs?=
 =?utf-8?B?dXBMOUFvdityNWFWaUJZaHVweHdtaG1RWGpIM0laUFZ1aXZpYXVXdUFqdUc3?=
 =?utf-8?B?U29MNTV1T3UxdkxCbE4rRnBPeDZDS1RRUmZjZEJXVm5jNFZNZllzWEMrNGRy?=
 =?utf-8?B?TXBOV2ExSXNpbEtBZ3BMTW8renJ6bXJ0b0RWRmdyRnhraE4wUnZ0TTQycE9W?=
 =?utf-8?B?NXRSUVhTZzdhOUdGZlk1bStBdktjT0ZCcVNCVnlGWWV5ZGZiRkdIV3pjVTZz?=
 =?utf-8?B?TGt4VzlIL2Z6bGNIS2cxQlFkc011SlNrandjeVFVRlR6TWhobE4xdk1FWTMx?=
 =?utf-8?B?cGRONzdmQ2g0QWRtTXR2a0RjNncyUDVoUXpzSjJxemlqYUhweklEQ0sraXRB?=
 =?utf-8?B?Z2F3Q3QxWGUyeXlZUzFGb3R1eWdVNlU0SmxEMjhGakxjRG9xMzJsUjM5aHNB?=
 =?utf-8?B?SGdibkJlRVRIN3htcGxoS3BpNXZGV0ZFUTdoVng4SVlGYllzaDB0YTk1OWov?=
 =?utf-8?B?UjhpNTd5OEIwOTR4VWhnUko3NEpNNnhFTjNVODBhdXZxV251OTdXcm5NdDBx?=
 =?utf-8?B?WFNPNWpEOVkxMjc5dFNFcUZtaURoaGU5TWdkMkhjNHgzOEtxTm9JYkhkZ1pi?=
 =?utf-8?B?TnZjRTdBYVUzWVp6REhORGNOSVkxbEwxdTVyTENQUEkvQitldEFENkxlT0h5?=
 =?utf-8?B?ZURIbXhsQmNlRWlqTTQyRzlkZXA3czQvd1FFUUJqMDZHMSszRVZGTGR6dlYv?=
 =?utf-8?B?b3Z6NlhpWWhhMG92cURmOVVhU3cvT1VDQjEvekZxQUxTSENyYndoc3VTaVpW?=
 =?utf-8?B?UDVrNDFIRUNSRzg5T0pEbE5kNEpVMFUzSy9rRDM4M3lieTNjMDJlSUpLSk1O?=
 =?utf-8?B?UWY1c2RocXdCbklMeEI4MEVQL0ltQW5RNzN5L2NyY3J5MUNSZmVUK20yVExH?=
 =?utf-8?B?ajVWU3p0WVFrbi94OXV6VzNjOEF4S2xpZ0JUUVVkM0FKelR0WlRVQmhJdWtW?=
 =?utf-8?B?S0VwejUycmNobWVPeXZZaHFJTmVoT0F6YXZLcG1kTklzL0tZU2Z0SENXSmVW?=
 =?utf-8?B?RFg0ZXBXNzdSclRjSmNua0d5Qk1kdW5nU2gwTTYzYXBrZ1hCSmxZUStQRFRn?=
 =?utf-8?B?MkNLbTBtRUZKWkhYakhBV092ZEplRDg4NFhMR1UxZDlxcXFhY01zQStmelVs?=
 =?utf-8?B?bisyanhIa3Vsa0gzOWk2bDk1QlQzRkh3SkxUUnNrQmpPNSswYS9WVTBiVmg1?=
 =?utf-8?B?TVUra0lJeldBeU5EME9reXVXcldySlp6WlZjYnYyTGtFZmFKMS85T1FkTTBu?=
 =?utf-8?B?ejhXYzBuVW1yaTZHWVNMTkVKc0Q5Q2g5QjhHRzRzVFJaV2ZlT0o3RXdWbHAx?=
 =?utf-8?B?Q1ZEaGxBNFdBRkhKRlNwZmVUUFBYNW85TTZUMVlacHhaNk45czcveHZDTzRt?=
 =?utf-8?B?NkowamU3aVdta3NYZkxJUE0vYVZHaGo2R0hodGNSSmRCNmZIU2VHSVZ4QXJw?=
 =?utf-8?B?b25NZUpqVm5sWHhhSzlmalZsei9QbXFGQjRTcVE0OERTVC9BZTRVNmJOOFVN?=
 =?utf-8?B?cC9xZUdURW9RTDljTWd1NlZFdFhiSjZ5c3o3a3pHZ0lDQkVKNmNjd2ExTDh5?=
 =?utf-8?Q?AMpjG0b+8Y8bYJb+ceSeKa4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c7c55e1-626c-4fd4-8497-08dc95d0beab
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 11:11:36.4011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7JD17XkcGOIuw4k/ULkOFx2HtBbx3zEX2XfQgYN5zMguMKOsUsZLuJvKl1OZtNy0qkkob6CFq2AfanPxzbc12bRRvCyejS0GujsVY9hcXF8TPxoV4i5qrPE/KJeBylsI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9613
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Jun 2024 11:11:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16322

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBjaXAtZGV2QGxpc3RzLmNpcC1w
cm9qZWN0Lm9yZyA8Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc+IE9uIEJlaGFsZiBPZiBK
YW4gS2lzemthIHZpYSBsaXN0cy5jaXAtcHJvamVjdC5vcmcNClNlbnQ6IFRodXJzZGF5LCBKdW5l
IDIwLCAyMDI0IDU6MDEgUE0NClRvOiBiYWxha3VtYXIgYWRpdGh5YSjvvLTvvLPvvKnvvLAgVEVV
UikgPEFkaXRoeWEuQmFsYWt1bWFyQHRvc2hpYmEtdHNpcC5jb20+OyBjaXAtZGV2QGxpc3RzLmNp
cC1wcm9qZWN0Lm9yZw0KQ2M6IGRpbmVzaCBrdW1hcijvvLTvvLPvvKnvvLAgVE1JRUMgT0RHIFBv
cnRpbmcpIDxkaW5lc2gua3VtYXJAdG9zaGliYS10c2lwLmNvbT47IGt1bmlqYWRhciBzaGl2YW5h
bmQo77y077yz77yp77ywIFRNSUVDIE9ERyBQb3J0aW5nKSA8U2hpdmFuYW5kLkt1bmlqYWRhckB0
b3NoaWJhLXRzaXAuY29tPjsgYXNocml0aCBzYWko77y077yz77yp77ywKSA8U2FpLlNhdGh1am9k
YUB0b3NoaWJhLXRzaXAuY29tPjsgaGF5YXNoaSBrYXp1aGlybyjmnpcg5ZKM5a6PIO+8pO+8re+8
pSDil4vvvKTvvKnvvKfilqHvvK3vvLDvvLPil4vvvK3vvLDvvJQpIDxrYXp1aGlybzMuaGF5YXNo
aUB0b3NoaWJhLmNvLmpwPjsgQ2hyaXN0aWFuIFN0b3JtIDxjaHJpc3RpYW4uc3Rvcm1Ac2llbWVu
cy5jb20+DQpTdWJqZWN0OiBSZTogW2NpcC1kZXZdIFJlZ2FyZGluZyBzdXBwb3J0IGZvciBXRlgg
YmFja2VuZCBmb3Igc29mdHdhcmUgdXBkYXRlcyBpbiBDSVAgSW1hZ2VzDQoNCk9uIDIwLjA2LjI0
IDA3OjU2LCBBZGl0aHlhLkJhbGFrdW1hckB0b3NoaWJhLXRzaXAuY29tIHdyb3RlOg0KPiBIaSBB
bGwsDQo+IA0KPiBUaGlzIGlzIHJlZ2FyZGluZyBzdXBwb3J0IGZvciBXRlggYmFja2VuZCBmb3Ig
c29mdHdhcmUgdXBkYXRlcyBpbiBDSVAgDQo+IEltYWdlcy4gSSBhbSB3cml0aW5nIHRvIHVuZGVy
c3RhbmQgdGhlIG9waW5pb25zIG9mIHRoZSBjb21tdW5pdHkgb24gDQo+IGhvdyB0byBnbyBhYm91
dCB3aXRoIHRoZSBpbnRlZ3JhdGlvbiBvZiBXRlggc3VwcG9ydC4NCj4gDQo+IEFzIEkgdW5kZXJz
dGFuZCB0aGVyZSBhcmUgMiBwYXJ0cyB0byB0aGUgV0ZYIGludGVncmF0aW9uOg0KPiAxLiBIb3N0
aW5nIHRoZSBXRlggc2VydmVyLg0KPiAyLiBTdXJpY2F0dGEgY29uZmlndXJhdGlvbiBpbiB0aGUg
Q0lQIEltYWdlcyB2aWEgdGhlIHN3dXBkYXRlLmNmZyBmb3IgDQo+IGNvbW11bmljYXRpb24gd2l0
aCBXRlggc2VydmVyLg0KPiANCj4gQXMgZnJvbSB0aGUgZGV2aWNlIHNpZGUsIGNvbW11bmljYXRp
b24gd2l0aCB0aGUgV0ZYIHNlcnZlciBpcyBhbHJlYWR5IA0KPiBzdXBwb3J0ZWQgYnkgU1dVcGRh
dGUgdGhyb3VnaCB0aGUgc2VydmVyX3dmeC5sdWEgbW9kdWxlLiBTZWUgWzFdLg0KPiBIb3dldmVy
IHRoZSBuZWNlc3Nhcnkgc3VyaWNhdHRhIGNvbmZpZ3MgaW4gdGhlIHN3dXBkYXRlLmNmZyBmaWxl
IGFyZSANCj4gcmVxdWlyZWQgdG8gYmUgc2V0IHdoaWNoIGlzIGN1cnJlbnRseSBtaXNzaW5nIGZy
b20gaW1hZ2UgcmVjaXBlcy4NCj4gDQo+IEJhc2VkIG9uIENJUCBDb3JlIHdvcmsgZ3JvdXAgbWVl
dGluZ3MsIEkgdW5kZXJzdGFuZCB0aGF0IHRoZXJlIGlzIA0KPiBhbHJlYWR5IGEgcGxhbiB0byBo
b3N0IGEgV0ZYIHNlcnZlciBmb3IgQ0lQIHJlbGF0ZWQgcHVycG9zZXMuIFdoaWxlIA0KPiB0aGF0
IGlzIHN0aWxsIGluIHRoZSB3b3Jrcywgd291bGQgaXQgYmUgYWxyaWdodCB0byB1cGRhdGUgcmVj
aXBlcyB0byANCj4gaW5jbHVkZSB0aGUgbmVjZXNzYXJ5IGNvbmZpZ3MgbmVlZGVkIGZvciBXRlgg
c3VwcG9ydCBvciB3YWl0IGZvciB0aGUgDQo+IHNlcnZlciBzaWRlIHRvIGJlIGNvbXBsZXRlZD8N
Cj4gDQo+IFVudGlsIHRoZSBwbGFubmVkIFdGWCBzZXJ2ZXIgc2V0dXAgaXMgY29tcGxldGVkLCBo
b3cgYWJvdXQgaW5jbHVkaW5nIA0KPiBkZXRhaWxzIG9mIHNldHRpbmcgdXAgYSBXRlggc2VydmVy
IGFuZCBvdGhlciBkZXRhaWxzIGZvciBtaW5pbWFsIA0KPiB2ZXJpZmljYXRpb24gaW4gYSBSRUFE
TUUgZmlsZT8NCj4gDQo+IFdvdWxkIGxpa2UgdG8gdW5kZXJzdGFuZCB0aGUgb3BpbmlvbnMgb2Yg
dGhlIG1haW50YWluZXIgYW5kIHRoZSByZXN0IA0KPiBvZiB0aGUgY29tbXVuaXR5IG9uIHN1Y2gg
YW4gYXBwcm9hY2ggYW5kIGFsc28gb3RoZXIgaWRlYXMgb24gaG93IHRvIGdvIA0KPiBhYm91dCB3
aXRoIHRoaXMgaW50ZWdyYXRpb24/DQo+IA0KDQpXaGF0IGFsbCBuZWVkcyB0byBnbyBpbnRvIHRo
YXQgY29uZmlnIGZpbGU/IEp1c3QgdGhlIGJhY2tlbmQgYWRkcmVzcyBvciBtb3JlPyBXZSBjb3Vs
ZCBtYWtlIHRoYXQgYSBrY29uZmlnIHZhcmlhYmxlIHNvIHRoYXQgdXNlcnMgY291bGQgZW50ZXIg
dGhhdCB2YWx1ZSBiZWZvcmUgYnVpbGRpbmcgYW4gaW1hZ2UgKGFuZCBsYXRlciBvbiBkZWZhdWx0
IHRoZSBhZGRyZXNzIHRvIHdmeC5jaXAtcHJvamVjdC5vcmcgb3Igc28pLg0KDQpKYW4NCg0KDQpb
QWRpdGh5YSBCYWxha3VtYXI=


