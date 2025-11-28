Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7ADD111A8
	for <webhook@archiver.kernel.org>; Sun, 30 Nov 2025 22:57:27 +0000 (UTC)
Received: from TYDPR03CU002.outbound.protection.outlook.com (TYDPR03CU002.outbound.protection.outlook.com [52.101.127.62])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1337.1764353871785334925
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Nov 2025 10:17:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=u2rq+9HC;
 spf=pass (domain: siemens.com, ip: 52.101.127.62, mailfrom: gourav.singh.ext@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ow+w0y0zWTzlKjEq6lTijaGYrXntRtOtZex8Rdv6Lh1o/Jwwco6XS4Na3XaTRX+//4cWtZU/E8sJSbAyjRj0S0hH6LW385CrwjAX4wsQU+R4NAh/ICkAAHYz9b2sUd+QlG+0igRzxaGvLwN0yhDew4WPeVLRa8VXMcSxdjMD+cDlbDjDSBs4WvHP9mil4KEl+OJfxYdDmydIRBVPhV6XdEZxfYPTWEgkYyScXJXScvqlaPIUPI160CikTuTIS9PfftjUs5fo57whPeopBeKgD81zEDconAJlsRw98AVS4RFWOkWn4GPKkZvfYLvzeRY4y7nO0Qj8REU4jY/SufaPeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5irmLKQZ4nQNqhju1yu09CqF1Mf0vyqplvGoxGhzKQ=;
 b=Y7LDvfgrXkiA4RRQQnWt2j73Y8vjv4mmGtblAAO3fWT0mTaIdqkVavedOTgrla3FKQMnu+YBpPw8jZaM++FA8vQWUuh7y20hmaXv8YvsVzidx4c1bqsWTvnNXDscaLnqEbme7h/tjFLEOjfP+Mi0RLXj/tH6xrRcAwf4mW2FqobVE9vO4Ti9kzrpFDR4HyXm4+jNuQ2XIQHWANdkfgEcBlO5Aw9YHBlHNbV9IPSOg67sFSnyGomel6kUzGpSlkry8SHZPIG68wzewR6Chk+xBbV+bGYQPfxb9GJQ/pBnrNs2Nd9pLlBvJEd9KPmH8sgKAmkDuVwp+B9pWXVJjwKxtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5irmLKQZ4nQNqhju1yu09CqF1Mf0vyqplvGoxGhzKQ=;
 b=u2rq+9HCdswyE5eWr6OytSvhfoeeIrAycny/DKy+ailjYjxCVehyV6GIvk2zfqXGlVDkgT1KKMYVFx9vd7ToMGyKgO/G4PWPtBYQrnEEjVuZzy9maEXKlh8jNeR1BzkbiQstWQmMmw2QCaTRZ/Yy3WmEZuMWZydBK5r24qUi0LHWzNEddC0GuGM3Lyh2zGq63jVhPhDpdo7E1EwB8aHpxS+dkiVTdTbzzYrRJpEeqwx6iaMFBlN1LMuxdhkibx0udegq5JLELoS3Yqu3NHx2I15ooOC/icNRcmroJ46E8XhCEtOpHCQNV9XAs4OMLXOCCPNMzPhvn6zP8RKDL41vGA==
Received: from KL1PR0601MB4697.apcprd06.prod.outlook.com
 (2603:1096:820:85::12) by SEYPR06MB6184.apcprd06.prod.outlook.com
 (2603:1096:101:c5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Fri, 28 Nov
 2025 18:03:33 +0000
Received: from KL1PR0601MB4697.apcprd06.prod.outlook.com
 ([fe80::d8cc:5aa0:b437:a0aa]) by KL1PR0601MB4697.apcprd06.prod.outlook.com
 ([fe80::d8cc:5aa0:b437:a0aa%3]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 18:03:33 +0000
From: "Singh, Gourav" <gourav.singh.ext@siemens.com>
To: "Shivanand.Kunijadar@toshiba-tsip.com"
	<Shivanand.Kunijadar@toshiba-tsip.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
	"kazuhiro.hayashi.f74@mail.toshiba" <kazuhiro.hayashi.f74@mail.toshiba>
Subject: Re: [isar-cip-core][PATCH] fix(security): add libpam-systemd in Debian trixie
Thread-Topic: [isar-cip-core][PATCH] fix(security): add libpam-systemd in
 Debian trixie
Thread-Index: 
 AQHcXQAcb4lZNF08PEGqGw5QdOFJ0bUBY1sAgACg96CAAALLgIABM9AAgASgQICAAC7NQA==
Date: Fri, 28 Nov 2025 18:03:32 +0000
Message-ID: 
 <KL1PR0601MB46979F20EA9D028D3ABF2C57D5DCA@KL1PR0601MB4697.apcprd06.prod.outlook.com>
References: <20251124050607.876836-1-gourav.singh.ext@siemens.com>
 <345f8c1e-0166-4946-893b-02dba9dd71ce@siemens.com>
 <KL1PR0601MB4697CEAF6AACC78EAB99E5CBD5D0A@KL1PR0601MB4697.apcprd06.prod.outlook.com>
 <e3ea7e4e-7679-4ddb-9074-fab4f51c8c8a@siemens.com>
 <KL1PR0601MB4697F954236371E6E07F0C35D5D1A@KL1PR0601MB4697.apcprd06.prod.outlook.com>
 <TY3PR01MB11075803A132ED49E1CFE0D57C7DCA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY3PR01MB11075803A132ED49E1CFE0D57C7DCA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=0001db07-203a-4ae8-ba26-24b6838cdfd4;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-11-25T10:58:43Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4697:EE_|SEYPR06MB6184:EE_
x-ms-office365-filtering-correlation-id: df1ac564-c232-4bae-727d-08de2ea871b0
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?OFlvWWN1Y3R2OEllcFhIbDQ2QkV4a0VkbkcrT3NZWE0yYUtDQStldzg5?=
 =?iso-2022-jp?B?SHczYldRTDBBTU5HSFF4bmZ6bmpuS2gxVmFJek1LV2RoNDk4U245SFNM?=
 =?iso-2022-jp?B?UUh3NzlFU3Y1aTE5QXpPRmZqM2dUUEM0N3hQUGFuM1FwNGllVWpKQlFo?=
 =?iso-2022-jp?B?cUxJd2ZsUWJQWFR6S2E5NHd2bm5DSG15RUJRNTVVbnFMU0hObGhKRXV5?=
 =?iso-2022-jp?B?emxFK2d5b2hzU3FOWlZ0OEw5TWhvbHhQcmxlSXNOQ0VPYWVaSVZhYm53?=
 =?iso-2022-jp?B?UmhQazBaeVZsMVN3aStHL0Q3V3RSN0g2azFxdW5zVk92SDN4azdxbmIx?=
 =?iso-2022-jp?B?Wnh0aUl0ZWxoSGlSYk8rSHNWTU1rSmNNMzFncTZtTDRwSWp6djhMaXJ2?=
 =?iso-2022-jp?B?cmg5c3hDQlcwaENoQ3U0RDFNRWQ5elpZbVM3WHJWL0RYTnV1QTRTOXp6?=
 =?iso-2022-jp?B?bGFVc091MHN1UndHWmEwMlJDTmpRSzdWWlFXNDZOZUJPOXRnTElaTUky?=
 =?iso-2022-jp?B?M2dZSDFQZTR3ZUhCUjlzN0l4SVp4QnVtMlBxdUN4OE9BTmpkRDVnaUVU?=
 =?iso-2022-jp?B?WGI0UC95bDBuK2pGQWNLZFkwNXF1blhWZ3VuMVFSNDhRSnh3eFo0UTYz?=
 =?iso-2022-jp?B?eUYzeEprWXBINEFXZzJmZE9qMHR4Q2lEYUM2WHRnbEtRMWR6cFhNRW1H?=
 =?iso-2022-jp?B?YUJBdm94Tk0rTTVzWWJ5RFpnR1ZLS05uK3U2V3pGSWVjRWNISENZZERl?=
 =?iso-2022-jp?B?ZTNpRU1ieThlR2ZNc0N6bFpSRkxlN3FzallUM21aVk9nUkNlWjhyOS83?=
 =?iso-2022-jp?B?WDdwNEE3NHNFZEc1Ly9rUnpJMDBRTWEvSUZOakdUcFVvMFEvNjU4a1Qw?=
 =?iso-2022-jp?B?dTVXL3Bndmw3VTA1Z0d0TGZtaVBXU3B4eWxtazM5VkFuSndmQUV5dzVw?=
 =?iso-2022-jp?B?dmUxSW5xRWJFTWFnbEJtK3g3OVErY2gzNjRPMDZveVZIK3N4QW8vdDdT?=
 =?iso-2022-jp?B?R21LVTZ0UzdjZ3RCT3IyOFNudTIrRHlYd2xVNVRrdU4wdUtZNjByNjlr?=
 =?iso-2022-jp?B?VHhjdldST3NkWUpnSmU4TGlJQ0ZiVllka3JTTkdTeHpkY0QzMUZTb1Yx?=
 =?iso-2022-jp?B?UUZDZTB3dEx1Y3RyMlBMc0dWbHFPUzNLS1AyTUFVRytOY2NvTjJVd0ZF?=
 =?iso-2022-jp?B?NzVDQVMvMm4rUU84a1hzdlVZTUdFRmlUNWVEQnFHdStVeEo4ZW1TVUhH?=
 =?iso-2022-jp?B?SnVlYi9GU1czR2xQSXdMekd3eUtWMDJmZXNwN3RHc1hIc2l1bGI4dXZq?=
 =?iso-2022-jp?B?VkJCRDlSMHE2WGhBQkt3RzhaNlJ1YVU3U0tiTDdheFA0aTl3bmNNTk9n?=
 =?iso-2022-jp?B?bCtZaytSZTEzVlljVUFtZkZjTDd1L2FZZ01pbmdVOXEwNkZmZzltUjk2?=
 =?iso-2022-jp?B?Ykk4L0IrRHlZdko3bU9SdDZhaWxybm1IQWhLK2JGS2Z2U0ZIV3c2T3kz?=
 =?iso-2022-jp?B?eWlxWVY3Ty9YSU91cThqNjBLYWttSzBzeEpYZk9aVFJiZGFJZHJ3SUFQ?=
 =?iso-2022-jp?B?SzRZWlBoMHVKVzNXUWM3VGpZUUo4d1JpeDMrV2xpOGhaREVsRHJWUXZU?=
 =?iso-2022-jp?B?NWlqYUQrVXlxT2tLMGsrbWZQZTlKMllUVC9VWXJzQUVqd1RsQ2prb3d4?=
 =?iso-2022-jp?B?RmsvdGFFaVNFT08vbHF2emo5bStMeTFpOFB3SDNGclVwMTJ4eS9sMHpO?=
 =?iso-2022-jp?B?YnRDd1NmdFBJNXFvMlkwekpzdCt3U3Z0T0grNWNTS0o2d3krS0ptbkhB?=
 =?iso-2022-jp?B?b25ZRTRpWEQ2MjNzbGFKK3NOUTBOQU1oY09maW5VTEY0cGMyTmFJS2NX?=
 =?iso-2022-jp?B?QVpQNVZFN09BK0RrakdXMEtRcWpIdy9IbWxOL0tZZWZkNmszeE5lQUN2?=
 =?iso-2022-jp?B?bGVBdDNFTmRvTHdpRzN3Z0FVZHFZbTBPajZiaUtGaitnWU1EZXNpcUEr?=
 =?iso-2022-jp?B?enBNdUlQaGwraDIwSStBUjdMNTltM2NWOCsyZjM3eXFkbFc4eXRURHNK?=
 =?iso-2022-jp?B?ME1YZy9yMUs3YkZscGlxWlRZZXZZOW1SQW9yNEdDR0ZGVEt5cXJKOVgy?=
 =?iso-2022-jp?B?aC9IVVZvdCtSa2lJZloyS0NCbDlqRSswblQ4ZXgxNHVuVUp3b3doNzNX?=
 =?iso-2022-jp?B?bmltOVBzQ3BXQjRJUG5QL25xS1l3cGQz?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?TjZMMnNtRW5LdlhJTTk5Ym1iT2R3cmFHTE1EVnZyd1IxTGNubEpUQVNp?=
 =?iso-2022-jp?B?Y2dkNnB4d3RHUjBBNXMrUU9Ca2NMUi9LWGNOS09nK0FwRWVMYlVNelBQ?=
 =?iso-2022-jp?B?by9FZ2d0SWF2azAzajRpdjd2UytBNGZPVFJlbGhvcTF5ZGtnN0Y1bUJw?=
 =?iso-2022-jp?B?ZmRiTlJkZm5yMjRzUnM1SVZYUFd4S1lEQUlJVTVVYzA0WVlVb1R2SS9w?=
 =?iso-2022-jp?B?a2E3blJuM1A2U3QrNng5UkRLMUZCalNYQ3lHcWRhZEVjb3dPazA5YU1E?=
 =?iso-2022-jp?B?SFNQQ2ppTFlPWStVUFA2SWlXL3JISy9HN0IwZHNuSlIzQnkvaU5VYndz?=
 =?iso-2022-jp?B?cXU5eGt0d3lNaVo3bi9TVml5ZzcyQm9SUEdGdFpEcCtEdlJvdDhwUGRi?=
 =?iso-2022-jp?B?VDdVVm1CaWIzS3Z5QlU1YWF6elBBbWtDSzlSTVN0L1pkQXFnczg0UEwy?=
 =?iso-2022-jp?B?TWx3SjdiYk9qZnM3VnBaSnNnaEJSM2JEOFJFak55UzlybDJhZ2FnUk1O?=
 =?iso-2022-jp?B?SFJ5WDdPT0hOdE5PZWJFTG5KamhaK3R2MnRVaml2OEFteG9TU3hlcTQw?=
 =?iso-2022-jp?B?T0RnMDh6TlE5amVMbXExS2NzRks4RjZQbGhOZXFOcnVuQUdjbjV3dWNr?=
 =?iso-2022-jp?B?cktLditXV2Q0TWFDK2owWWZ0OE9ObVk5WjFGNEpzRUpnT3pYUWpJUWNK?=
 =?iso-2022-jp?B?NjBzOFM2WjU1UWVYUjJZN2wvRk43RVNPUW1CS0puZkF6djJHc09QdWlO?=
 =?iso-2022-jp?B?WUtBQ2ZBc3ZpMGhsU2FMbnZaRk41dFh0UlRjMElXY0htcGtaMytPVm9L?=
 =?iso-2022-jp?B?Q25wK1c2UktRczA3akFEZk4ycVNzSlN6UTJmeTh6S0FKR3V0cjlDeXRk?=
 =?iso-2022-jp?B?WnFkbHJPTW9XL25qTElDV3dhS08vMWo2dkZzc1ZiLzA3ajFpVXRUaHVF?=
 =?iso-2022-jp?B?MkMycDRvVHhzcS9xdFJCa29OQWN6c2ZYUXJiVGIvcFBtcmFGVjdrWW5T?=
 =?iso-2022-jp?B?M3JRVmRBNGp2eEdNdjk0NUxidXl2SGk1WVlMT2N2RkZyc2t4bTYzZnVG?=
 =?iso-2022-jp?B?MzlvdmdNbHdKVTJWV0hxdmNvdk0veVBYeEhQTit5TXBMbjV1UndJNFVI?=
 =?iso-2022-jp?B?cVZYRU9pa1dsQXFkc1h3K0dYamc0Ny9WR0IyTWZnRmVtU0FHOWUzaWFh?=
 =?iso-2022-jp?B?U2J0OWVLZDZZSnQvcjVXRmxVd1dHNlJ3YjdmbUptWGIvZjlvL29yQnJP?=
 =?iso-2022-jp?B?QnJnNFp4aUZ2YXhwcUFBK1pFVHdxM09RQ3A5K1YxK2xrQjhBNWt5eGJZ?=
 =?iso-2022-jp?B?cU9iTE1qYTNqWEJrT1pBOEhkOTI3RDVQQUsxVXc3dXJSK3dPUmtWenVS?=
 =?iso-2022-jp?B?eHp3a21iQTdEaGthSGdqNUNQa25HVFNKelNsOG8wRExBQXFpVnhGenBs?=
 =?iso-2022-jp?B?UVNIL3JXd2FQYlQ1K2cxTE9BNkN4S3ozdjAzNGw3QnB2aFp0YXFMdW1Q?=
 =?iso-2022-jp?B?UjI5Slk1OTh5akl6b0oyYjRzMFdVdkNTUy8zdDdRdnU4ZHdPY2hVbmlH?=
 =?iso-2022-jp?B?SlVjaTB2cFVIa3VpdEgzdzJZOTRYa3lDbFZoQWhXSlBWTGdHY09QNlJN?=
 =?iso-2022-jp?B?bHBnNVo0MTF4L3RiZ0R1RmF6enk4QXIwQ3lRU294cERTQ051WWxCZEw0?=
 =?iso-2022-jp?B?NFNWZUVvWGprNG9vcHdqY3dhTHc4dkNGQSt3dGNDUUk2Rzl1Um4zQ0g0?=
 =?iso-2022-jp?B?MG5FK1J1VVZOT0Jobnk0TE9KeUFFSDhiYllpU1pSODc0MkxtWWFCRGxs?=
 =?iso-2022-jp?B?MktXQXUyZHR2SGNDdmpNbGJxc3B6bDJvUGtRL1MxRFZPOXNqT3UyUzB0?=
 =?iso-2022-jp?B?YUpoU0Q3dzhLWmhDUzBoOTBlWmxEaHZMUEhVZkZYbjhmWHlBRXFGci8x?=
 =?iso-2022-jp?B?V1dLZDl5UjZkZUt4cEtwa1dnaFVCUC9KQVRleW42aWl1aFNURHUvM2Z2?=
 =?iso-2022-jp?B?Zm1remtIRmpqR2kwb2huLy84S045SEpzZzJiUGtpREFpMGw1a0hoclFx?=
 =?iso-2022-jp?B?ME1XRXozZy9SWXJ3dzEzOHRjOTZWMEsxNG1kcS83YmtBUi8rWW1sbXpk?=
 =?iso-2022-jp?B?L2Nxc2ZKTDg2OFNhTjVvclBYWDg1TVJ6MFRKWUNobEIxT0kzV1dNWlg0?=
 =?iso-2022-jp?B?WlM5d2dEaEVKZzNnbmtOM3JpZW83NmRKbzVZUXlRYllQUHhqTUdyUGpS?=
 =?iso-2022-jp?B?SVFYN2RLcHhTTDJYTExveG1WOEMrVlQ2YWlSU0FPWmRzK2dTQy9IOW1w?=
 =?iso-2022-jp?B?b2lyaVRhUnM3U0RHR2lqQURmWlRuaFFtckE9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df1ac564-c232-4bae-727d-08de2ea871b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2025 18:03:32.9395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aF9v14pNUzKCHPtHyvB3C9vIZN4Xw+InwUdbipBTLQZQvJjk8P+UjDAme4kxtt+DLaSGLrmGdiSK/LZd8laX/a5Hr/fqMSJThkIxfdRev/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6184
Content-Language: en-US
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 30 Nov 2025 22:57:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20772

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
p.com>=20
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


