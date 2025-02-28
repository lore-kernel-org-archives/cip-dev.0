Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59B2C19776
	for <webhook@archiver.kernel.org>; Fri, 28 Feb 2025 12:16:08 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.66.49])
 by mx.groups.io with SMTP id smtpd.web11.14075.1740744964377445448
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Feb 2025 04:16:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ReqfpviB;
 spf=pass (domain: siemens.com, ip: 52.101.66.49, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHLPnAQE6ukIwCIIt+fmueRsp/4AM0FbVZGtVfjDLM96dp4i4bftOY/6zqIygUHEuAN4bTi5gjVvIZoA5kqZLZk6iAjllIrV6aASscdxlHBTMeIvU5gdYiRAo11Z2ruyB7X8ulI4RRGh92SV/Gzey7aioUcut3EmQjP1D2201RFcgg6FSmJ6PojMWbJrgRCk8ycnafv4ht+hUpN75mbtIo7hkMxzGhoT16WaJWAptJGNIpo+5+i9UtobBbD3b54DvdvIYdgoc2OrLpYDDgV7bWcUPrVjcP1NtqpLCovcM/DMW6NTX3gdK/IBU0wrtSEED3bMRp3x271sjAKRUat2OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmbtIgQHKPSXxod/+B7qN11XGFH79Ia4iELQRJREHP8=;
 b=U7LQmYDK7Mhh6pNP33CEFHE1Geu88KGJv7G2eOsqLpOHX3vyXv5hcbxnbmi3Fcn7rURl0snJ6APIDJ2pY9g42MRP4CLrx/qPvYnjVa5DlVR90v1TJD84vI3D0kacY6zYRZ9m9+M9N/ExeaPqJu6QY/VJO/La5O0pZRu6zo0kBrmQ1OVUm23pVCAhaZkPgrMbR8VwYeFaSKkLeNVThy1/bVVQdaCHaX023el4Htk/b1r9cFbKd5PwKMRC/M4iHAuToALprQArzFn3Z9x79eGVr2FDxzFrWc5iRormD2V+kRP3KL6PvZs7U/LjojRwy7kyXntYu+C566sg62rJhmZV6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmbtIgQHKPSXxod/+B7qN11XGFH79Ia4iELQRJREHP8=;
 b=ReqfpviBZ3PG1jwkcpTO06AsJ0yrkM6553ALpbQXcl/tu1dAp0EqhJenVL8R+GVZQEhbZZ6greRAw+gDv88jFZbTxOSFFAvrDgg0rZzpfed2RolYp8+8aHv1bJueTUHFlYo59QKQIDfJsOji0tqj5f+FAYgNTaqM7pYr2Zk/qL4BkeK4nmQ/h2mQNFE8AUG5YAFGuZ7gsEsaq4O7LYWcQRu87PL0oovB5EPq6SaHPOmaVoojR223Vkzt7EM8kOjN0S4HAql7e62YBGnzajPQdHBaUgJ9OeHdCBVNE1yF/3A4wlXmhoPx1ybre9gfZI2iDym9OQtieewBUl1HwY+PmA==
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10c::13)
 by AS2PR10MB8034.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:559::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 12:15:59 +0000
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0]) by AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 12:15:59 +0000
From: "Heinisch, Alexander" <alexander.heinisch@siemens.com>
To: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>, "Kowalsky, Clara"
	<clara.kowalsky@siemens.com>
Subject: RE: [isar-cip-core][PATCH v3] initramfs-crypt-hook: Optimize disk
 encryption in combination with expansion of last partition
Thread-Topic: [isar-cip-core][PATCH v3] initramfs-crypt-hook: Optimize disk
 encryption in combination with expansion of last partition
Thread-Index: AQHbiKYrs69lsQmhTkinNrMPdw+Aa7NbFVCAgAGJmtA=
Date: Fri, 28 Feb 2025 12:15:59 +0000
Message-ID: 
 <AM7PR10MB332086987071787C6ED4365286CC2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
References: <20250226232812.374892-1-alexander.heinisch@siemens.com>
 <ab056b18-b274-4e42-8d68-9eff0d1dccf7@siemens.com>
In-Reply-To: <ab056b18-b274-4e42-8d68-9eff0d1dccf7@siemens.com>
Accept-Language: de-AT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=bd97653c-5dd3-4c2c-a246-528acf92b1dd;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-02-28T11:58:40Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3320:EE_|AS2PR10MB8034:EE_
x-ms-office365-filtering-correlation-id: e12e6673-c129-48d1-8ada-08dd57f1a939
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?SDVGdlZUN3Fmc3dwUTVZdTJRZ2dJazZSanFtd0poMW9KclFBTlJoRmIrR0lS?=
 =?utf-8?B?Rm5BejlsRHhWeVNsMWE4QjNOTkRmYlFwcVduOWJBTFhXVjJQOWM1ZlNTUGkz?=
 =?utf-8?B?MEZLZDRKOFVqMVZoZ3R0WUo1SUJGUmVZZTkzaDBCb1ZHWWlEbVBIQ2JuMnVt?=
 =?utf-8?B?NnBTaU5lSi9DVnRzTHVGRzhMUmppOUdGcE14dG5RbDgxTmhVY2wzOFllaCtP?=
 =?utf-8?B?Y2dhZlY1UktJRzVoaU1kTTlWZ3pLeVRSU0lZVXc5ODM4N3NqbWVVbzN4MXVO?=
 =?utf-8?B?MVg2Ny9FUWh0Yk9CQmhxcTk0MzdGWEptOU9wbW1iMk00aU9OY1ZWSjlVbDVQ?=
 =?utf-8?B?ZnpXSzBxaWNDdTJJMlNUNEErNXZoWnRuNHZJa202cm1YL2JoZTU1RUdRN2hn?=
 =?utf-8?B?azBFa0JjcXRkR0FSQ1BLaUZSNWtqVlI1UllyUXRKcS9UYzBIRzhLYjhsd3pL?=
 =?utf-8?B?Q0JYOGlGMzZJVUpOZ2FiV01OVzhvVU1iS0NVWitVUDR5R3UyRThjWHBOZWlB?=
 =?utf-8?B?VjBobFpkblVnWjFoTEwyMFdlU0c3d2xoOUVablU1VlYyYXVxMitudmp4OVZv?=
 =?utf-8?B?VlRXRVlNMG5Pd0w4cVpIU2ZkMGM5MVNjS0hlRGl5cllQWldtMC9uekVVWHc5?=
 =?utf-8?B?YUpGdDhNMFpwMm9UQmVGWE1FcHI0RWVTRDl6ZlJJMGpWUFhhMnZtd3kwL2k4?=
 =?utf-8?B?aTd4K3cwRHJWRWZVNTJWU1lDaFN6dFcrbEM0TEJHQ1owcXlBSGFiYUFJeGFv?=
 =?utf-8?B?SWY4MXF5eW40UXJTVkZqbnhuMU4wdDZwQ2xaRThDb21yR1ZjTkI0eHdiaXpj?=
 =?utf-8?B?OXlXcHZ5N081ek9qMGF3QXNPUkptVFNPUU1pQzhjUUdJTUMyM1F5OFdZbDZ2?=
 =?utf-8?B?dU5od2ROdi9xYy9Uck80NGthd1FmZzdJR1JubTBhZTlWeFNXMGRXUTBBSGk0?=
 =?utf-8?B?a1I4RGRZa3Fpc0VFc295aTFjZUJLbXdLRTZ1SThVNVV5OE8rUzErYThtTmRU?=
 =?utf-8?B?SGxLRFVDWjg3Nk5PT0JoUzlCR0ZhRUE4TndpTXJkd2JuZEZvd1dJUWVxRmI0?=
 =?utf-8?B?MXRZVkJYQnFKY0RCZjFLOGxTV3ZqdElVeTh4d3N0UmlSbUdZU1BUdkJHUTE0?=
 =?utf-8?B?WFg0ZXdPMVpVb1JCU0FZTXoyOE5sWmVpeGtMN2Nqc1M0THZjbW5ib0k5YzMv?=
 =?utf-8?B?ei9XNktLSW1NMVJNOEFxbFYzMzVkVlVRaXpPNU1uZ2c0VUIvS2dYMGFRY2M2?=
 =?utf-8?B?YUdwNUpoSjFuRjVaWlduMVo0V3cyU2owSVBwQ1pQQkxwWWpQRnNMZWZKZTJy?=
 =?utf-8?B?UmJCa0dTZEpRelpNdENYck5GUFIwTGR5UVJacUpRVjZuelRMc2kxaXF3T3E3?=
 =?utf-8?B?amJDSExPMHZ1NmZ4dm1WdWZDbUJqSVdWZFpzOFNmZGt5SlFuOWpTdDFpZWRS?=
 =?utf-8?B?eStzRkZuNGRoUTJtcThXcjlZRHNjMURUVWVJd0d5QW1ScEJibTFvaFFWMmRa?=
 =?utf-8?B?Wm5LcUIrcDIvblFFUVV1YnlMcnpENmppYU9XekhvWnFBYU95d2RuWDUvWHpN?=
 =?utf-8?B?VE10dUhhK2g0QjdQV2lRbCtFODRhNHVVcU9nVmRXOEVhRzFjUlhDWGdrYTlw?=
 =?utf-8?B?RHhNNzVQSTZWdmFPN2dRZ09HVGdJQ2hES0xvbnRZVlAwOWJEaEh0ZFFtZ0xI?=
 =?utf-8?B?NmhmT3c5RFo2ZEtURHZXQkZpVlo5UXYzWVpVY1JSZzFDQ05VSlZjWVhPWTZT?=
 =?utf-8?B?a0d1anBRKzVUOUdnY2tZYjluT2hUbVhhU2syTTRvNHhpb2x2eEJxclVIanR4?=
 =?utf-8?B?MCttdHJSbjR5RXNrdkZKcmtpazE1aytibU1JRkozRktYbTlMcCtjUnRQWUIr?=
 =?utf-8?B?c3BuaFc3THlEMlB3S05YWlA0SllqNWRtTTM2elNUQk8vSDZHOTFmV2JBQ0xz?=
 =?utf-8?Q?bd8g1LcXR5LdRlUUWLcPaoXAQxGxudLy?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YXREd3JBdWh0RlIrWjJKdGlReUlQVFJXZE8rSUhSVHNHdUNpVkNwalNVWWNB?=
 =?utf-8?B?ZXozcE9Ya2wyRVY1ZEhvYTJDT0ovVW9PY3JPQlZnNisvY2FQb3JFQnJIWEQ2?=
 =?utf-8?B?cVYwSDZtdlZUY0RLVFdndno4bURHcDVVbmFmZ3Y5a0toRnNnT3ZDVGJkQXcr?=
 =?utf-8?B?VVBMcUplVHRLazRRMm9SaEJZVXVyQ1V5SDRHT2ozS1lRN2xQZkxVa05sU3dB?=
 =?utf-8?B?RlhMTTlXcmNVWk1wNXNWSzdmM1BDZHVzeEtLdWUyb1F0MUdGcU04VlRhdGlZ?=
 =?utf-8?B?elQ5M0FxcUFDWFBFQUtQbWZMWWlxNXF1RXJ3ZjRtclNRQ2MzcUprcVlDSGt4?=
 =?utf-8?B?TDdMNjlhbHRSb2p6aDNQa29OczFQd2pPZnAzTmpTRFBsNGhEdTIrSTdnMTdB?=
 =?utf-8?B?TkJQdS9oOXBjSS9GNTZSTkNVU25sWjRaQ2RJU3lMQTRkSjdTSGE5dWw5OUlk?=
 =?utf-8?B?ckluZVN4MzNKcGpFaVYvcHBQS3JvRmowdHlyUTZyZWo3Tjl6bWVKMDNWN3VM?=
 =?utf-8?B?WUV4ZmlvNE9vQml0aW1BYVhFOEFuMXdpVEFRd3AyNWtxSHpkU2tPZGNxSlRF?=
 =?utf-8?B?eVpSQ0RaYSt1SzdOMmQxTGcyK1lQeWtLbXVJd0VZR0xwYXg1MzJZMGxUWE05?=
 =?utf-8?B?eENjT3JRcmhXL2dGZ3JrR1A2SDdrRFRzWEhWZkhEaTJhUm5nVUhZUDM1UGFX?=
 =?utf-8?B?T0FaL0JaZFB4YWJ4ZVdnTEtKVXpiL0l6OVU3N2M5V3FOMEF5ZGJQTDE2d1pn?=
 =?utf-8?B?cUtBeGQrZThQb2dkMDJ3Y2dJZGdOdmEzOVl6cFkxWlNpSXd1UDhjNjhhSmlB?=
 =?utf-8?B?UU1WNkVXVFNzZS8xbXcxeUZaZkxxVTA1MGVGc2d5TGlkL2lsQWFOM2kvSEZ4?=
 =?utf-8?B?Y1VwRUtKT1RLZEtRSHpRdGtaRUtjRDZQS04wVzM4Ty90ZjQ5ZFlkcHlLTm9M?=
 =?utf-8?B?Y3RqZmJsZ2VtT1NzSUowVXVmZ2Fwd3JTRW1ndVB4YWpPbjgxaXN5MytnempD?=
 =?utf-8?B?bFJPRXUwTVRSZDYwOTZ6R2RubTd5WEgzeUxTdzdtaE9oWGoxQ3dSMW9DSC9W?=
 =?utf-8?B?NnFoWmQ1MWxVaDNwQUlGZXR5bmZKWjVzSjl0dzMwczhhY0xPQWNEa2N5UkxZ?=
 =?utf-8?B?WFJPN2krUjZDSDJGcW9NM2wyT1pCVElpVllEMU1KWExmTS9CK3BDNjQ5ZVdW?=
 =?utf-8?B?K1dNSkFmN1lmUTRhcFJGZytuY0YzUEN5bDB0YmlubFdITTBlUXNxeUpiK0NZ?=
 =?utf-8?B?clBOY2laYVljVU80YWJjVmpzcm5SZTEvT0orSGUxTWYzVXQ3TWJYR1RwVS9W?=
 =?utf-8?B?cW9OVTRGSUczZnp3RktNa1l2ME5VOTcwMlNIRUdDRTJHekh0V2lCK0ZkZkdT?=
 =?utf-8?B?dUwxSXdLRzFUUDFiOVlHOGlYNk9mcXJhK2M0dnZDUjgzN1p6YTl1azFOdlBW?=
 =?utf-8?B?cjM1eGpoKzk5ZGNmdUNHTU9FaFlGam8ram5aZlZvMkdIRXNMLzExdkhxZzZv?=
 =?utf-8?B?ZlZKbzdudGFnNEVFUFpQcFNjWWM0TE9keGtEYUhSMWY3VzNXYzJsdXhLY0JY?=
 =?utf-8?B?K3BGWG9tUlh1NTFQSlRWVVRWcVc4Y1Z3cWVYOFNua0hxY3FjZjJ6Y29uRFdw?=
 =?utf-8?B?NnpYcnJDWTFXS2R1UE1zQ1BWYlBnSi9HY2FxY3BFM2NGV1lxenZMUVVvTlI4?=
 =?utf-8?B?MEpmTW9GZkViV0FRU3Bxcm1aSElSak1qNW5yQ1M0dURTdDRPbGVkQXJCUFdW?=
 =?utf-8?B?Y1ZBbGJZYjVSZUhzMG8vcXgzbE1NRjRsaWxHc05wTktTUUFkZmhlWFlSSTZ2?=
 =?utf-8?B?TkJwN3JXbXErcDJsZ09icmNTV3U1NWgxeWhuZlpBMzJjQnRnOUE2SURFNi80?=
 =?utf-8?B?d3Nsdkg2THprU3dFZmJkVHpGYkd5ZHFuRy9qanAwMXZWenhaWXF4QzRPWWNL?=
 =?utf-8?B?QXJJcGdFNDZaQzRPUlNhTklEOER6MkpKQ2dZQ3Z3Ny9mK3V2L1BoVWdrcUI1?=
 =?utf-8?B?Yy9iRGpFRFJWWXpydUtvSkpsOTNnZ2VPeWxVVlBxV0ZDdXZqUFhURmN5NGQw?=
 =?utf-8?B?ZVNTWlFYY2IrYTVsMjVDbkdjdmV0clF3TFJBdDZXUzVHMHBDWVVIdWZWN1JL?=
 =?utf-8?B?RlFUWDdHOENVUjV4Q0pHanlObklZd05LMDdCYUgzelhYZFdDWVUvem1TRjd1?=
 =?utf-8?B?K3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e12e6673-c129-48d1-8ada-08dd57f1a939
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 12:15:59.3859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GvCXGZknLPUBFDiKMJCw/27MoK1oVepK9F19PMCJXMmKfvLrDMAtZj67XMU4rimJVZhNHiWNvffQUMIcZAU8yO6fTRGImTqrkDEhcSzNqec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB8034
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Feb 2025 12:16:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17983

Pk9uIDIvMjcvMjUgMDA6MjgsIGFsZXhhbmRlci5oZWluaXNjaEBzaWVtZW5zLmNvbSB3cm90ZToN
Cj4+IEZyb206IEFsZXhhbmRlciBIZWluaXNjaCA8YWxleGFuZGVyLmhlaW5pc2NoQHNpZW1lbnMu
Y29tPg0KPj4gDQo+PiBJbiB0aGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiAoc2luY2U6IDI4NDE3
NWMzKSBkaXNrIGV4cGFuc2lvbiBsb2dpYyANCj4+IGlzIGRvbmUgYmVmb3JlIHRoZSBhY3R1YWwg
ZGlzayBlbmNyeXB0aW9uLg0KPj4gDQo+PiBUaGlzIHJlc3VsdHMgaW4gcmVlbmNyeXB0aW5nIHRo
ZSBmdWxsIGV4cGFuZGVkIHNpemUgb2YgdGhlIGRpc2ssIA0KPj4gaW5zdGVhZCBvZiBvbmx5IHJl
ZW5jcnlwdGluZyB0aGUgc2VjdGlvbnMgY29udGFpbmluZyB0aGUgYWN0dWFsIGRhdGEuIA0KPj4g
VGhpcyByZXN1bHRzIGluIGEgZHJhc3RpYyBpbmNyZWFzZSBvZiB0aW1lIChhcHByb3ggMjB4IG9u
IG91ciBzeXN0ZW1zICkgbmVlZGVkIGZvciByZWVuY3J5cHRpb24hDQo+PiANCj4+IFNpbmNlIHJl
bGV2YW50IGRpc2sgY29udGVudHMgYXJlIG9ubHkgYXZhaWxhYmxlIGluIHRoZSBzZWN0aW9ucyBv
ZiB0aGUgDQo+PiBkaXNrIGF2YWlsYWJsZSBiZWZvcmUgdGhlIGV4cGFuc2lvbiwgaXQgaXMgc3Vm
ZmljaWVudCB0byByZWVuY3J5cHQgdGhlbSBvbmx5Lg0KPj4gDQo+PiBUaGlzIHBhdGNoIGNoYW5n
ZXMgb3JkZXIgb2YgZW5jcnlwdGlvbiBhbmQgZGlzayBleHBhbnNpb24gcmVzdWx0aW5nIGluIA0K
Pj4gZmFzdGVyIGVuY3J5cHRpb24gKHNpbmNlIG9ubHkgdGhlIG5lY2Vzc2FyeSBwYXJ0cyBhcmUg
ZW5jcnlwdGVkKS4NCj4+IFRoZSByZXNpemUgb3BlcmF0aW9uIGRvZXMgbm90IHJlZW5jcnlwdCB0
aGUgYWRkZWQgZGlzayBwYXJ0cyBidXQganVzdCANCj4+IGV4dGVuZHMgdGhlIExVS1MgY29udGFp
bmVyIChjcnlwdHNldHVwIHJlc2l6ZSkgdG8gcmVmbGVjdCB0aGUgbWF4aW11bSANCj4+IGF2YWls
YWJsZSBkaXNrIHNwYWNlLg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kZXIgSGVpbmlz
Y2ggPGFsZXhhbmRlci5oZWluaXNjaEBzaWVtZW5zLmNvbT4NCj4+IC0tLQ0KPj4gDQo+PiBDaGFu
Z2VzIHYzOg0KPj4gLSBQcm92aWRlIGtleSB0byBjcnlwdHNldHVwIHJlc2l6ZSBmb3IgY2xldmlz
IGJhc2VkIHNldHVwcy4NCj4+IC0gcmVtb3ZlZCBleHBvcnQgb2YgRVhUMkZTX05PX01UQUJfT0s9
MQ0KPldoeT8gaXMgaXQgbm90IG5lY2Vzc2FyeT8NCg0KVGhlIGltcGxlbWVudGF0aW9uIG9mIGBl
MmZzcHJvZ2AgdXNlZCBmaXJzdCByZWFkcyBgL3Byb2MvbW91bnRzYCBhbmQgb25seSByZWFkcyBg
L2V0Yy9tdGFiYCBpZiB0aGF0IGZhaWxzLg0KDQpUaHVzLCBgRVhUMkZTX05PX01UQUJfT0tgIG9u
bHkgaGFzIGVmZmVjdCBpZiBlaXRoZXIgdGhlIGZpbGUgYC9wcm9jL21vdW50c2Agb3IgaW4gYWRk
aXRpb24gdG8gdGhhdCBgL2V0Yy9tdGFiYCBkbyBub3QgZXhpc3QuDQoNClRoZSBmaWxlIGBwcm9j
L21vdW50c2AgYW5kYC9ldGMvbXRhYmAgZXhpc3RzIG9uIGFsbCBzdXBwb3J0ZWQgZGlzdHJvcy4N
Cg0KVGh1cywgaW1vLCBgRVhUMkZTX05PX01UQUJfT0s9MWAgaGFzIG5vIGVmZmVjdCBpbiBvdXIg
c2V0dXAuDQoNCkJ1dCwgZXZlbiBpZiBpdCBoYWQgc29tZSBpbXBhY3QsIHRoZSBob29rIHdvdWxk
IGhhdmUgZmFpbGVkIGFscmVhZHkgDQphdCBgcmVzaXplZnNgIGR1cmluZyB0aGUgYWN0dWFsIGNy
eXB0IHNldHVwIGluIGByZWVuY3J5cHRfZXhpc3RpbmdfcGFydGl0aW9uKClgLg0KDQpCUiBBbGV4
YW5kZXINCg0KPlF1aXJpbg0KPj4gLSBBZGRlZCBzdXBwb3J0IHRvIGV4cGFuZCBwYXJ0aXRpb25z
IHdpdGggYnRyZnMNCj4+IA0KPj4gQ2hhbmdlcyB2MjoNCj4+IC0gUmV1c2UgZ2V0X2ZzdHlwZSBm
cm9tIG1raW5pdHJhbWZzIHNjcmlwdHMvZnVuY3Rpb25zLg0KPj4gICAgVGhlcmVmb3JlLCB3ZSBj
b3VsZCBhbHNvIGdldCByaWQgb2YgbW91bnRpbmcgdGhlIHBhcnRpdGlvbg0KPj4gLSBEcm9wcGVk
IHN1cHBvcnQgZm9yIGJ0cmZzIChjb21wYXJlZCB0byB2MSkgc2luY2UgY3J5cHQgaG9vaw0KPj4g
ICAgZG9lcyBub3Qgc3VwcG9ydCBidHJmcyBhbnl3YXlzDQo+PiANCj4+ICAgLi4uL2ZpbGVzL2xv
Y2FsLXRvcC1jb21wbGV0ZSAgICAgICAgICAgICAgICAgIHwgMzcgKysrKysrKysrKysrKysrKyst
LQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkN
Cj4+IA0KPj4gZGlmZiAtLWdpdCANCj4+IGEvcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLWNy
eXB0LWhvb2svZmlsZXMvbG9jYWwtdG9wLWNvbXBsZXRlIA0KPj4gYi9yZWNpcGVzLWluaXRyYW1m
cy9pbml0cmFtZnMtY3J5cHQtaG9vay9maWxlcy9sb2NhbC10b3AtY29tcGxldGUNCj4+IGluZGV4
IDVlZjdjYTQuLmZhYzZkYjYgMTAwNjQ0DQo+PiAtLS0gYS9yZWNpcGVzLWluaXRyYW1mcy9pbml0
cmFtZnMtY3J5cHQtaG9vay9maWxlcy9sb2NhbC10b3AtY29tcGxldGUNCj4+ICsrKyBiL3JlY2lw
ZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1jcnlwdC1ob29rL2ZpbGVzL2xvY2FsLXRvcC1jb21wbGV0
ZQ0KPj4gQEAgLTEwMiw2ICsxMDIsOCBAQCByZWVuY3J5cHRfZXhpc3RpbmdfcGFydGl0aW9uKCkg
ew0KPj4gICB9DQo+PiAgIA0KPj4gICBleHBhbmRfcGFydGl0aW9uKCkgew0KPj4gKwlrZXlfZmls
ZT0iJDIiDQo+PiArDQo+PiAgIAlib290X2RldmljZT0iJChlY2hvICIke3BhcnRfZGV2aWNlfSIg
fCBzZWQgJ3MvcFw/WzAtOV0qJC8vJykiDQo+PiAgIAlsYXN0X3BhcnQ9IiQoc2ZkaXNrIC1kICIk
e2Jvb3RfZGV2aWNlfSIgMj4vZGV2L251bGwgfCBcDQo+PiAgIAkJICAgICB0YWlsIC0xIHwgY3V0
IC1kICcgJyAtZiAxKSINCj4+IEBAIC0xNTUsNiArMTU3LDMzIEBAIGV4cGFuZF9wYXJ0aXRpb24o
KSB7DQo+PiAgIAkjIEluZm9ybSB0aGUga2VybmVsIGFib3V0IHRoZSBwYXJ0aXRpb25pbmcgY2hh
bmdlDQo+PiAgIAlwYXJ0eCAtdSAiJHtsYXN0X3BhcnR9Ig0KPj4gICANCj4+ICsJbGFzdF9wYXJ0
X2RldmljZV9uYW1lPSR7bGFzdF9wYXJ0I1wvZGV2L30NCj4+ICsNCj4+ICsJbWFwcGluZ19uYW1l
PSQoY2F0IC9zeXMvY2xhc3MvYmxvY2svIiRsYXN0X3BhcnRfZGV2aWNlX25hbWUiL2hvbGRlcnMv
Ki9kbS9uYW1lKQ0KPj4gKwkjIHN5c3RlbWQgYmFzZWQgc3lzdGVtcyBkbyBub3QgbmVlZCB0byBo
YXZlIHRoZQ0KPj4gKwkjIGtleV9maWxlIHByb3ZpZGVkIHNpbmNlIHN5c3RlbWQgYmFja2VuZCBm
b3INCj4+ICsJIyBjcnlwdHNldHVwIHJlc29sdmVzIHRoZSBwYXNzcGhyYXNlIGRpcmVjdGx5DQo+
PiArCWNhdCAka2V5X2ZpbGUgfCBjcnlwdHNldHVwIHJlc2l6ZSAiJG1hcHBpbmdfbmFtZSINCj4+
ICsNCj4+ICsJbGFzdF9wYXJ0X21hcHBlZD0vZGV2L21hcHBlci8iJG1hcHBpbmdfbmFtZSINCj4+
ICsJZnNfdHlwZT0kKGdldF9mc3R5cGUgJHtsYXN0X3BhcnRfbWFwcGVkfSkNCj4+ICsNCj4+ICsJ
Y2FzZSAke2ZzX3R5cGV9IGluDQo+PiArCWV4dCopDQo+PiArCQlyZXNpemUyZnMgIiR7bGFzdF9w
YXJ0X21hcHBlZH0iDQo+PiArCQk7Ow0KPj4gKwlidHJmcykNCj4+ICsJCW1rZGlyIC8ubW50LXRt
cA0KPj4gKwkJbW91bnQgLXQgYnRyZnMgIiR7bGFzdF9wYXJ0X21hcHBlZH0iIC8ubW50LXRtcA0K
Pj4gKwkJYnRyZnMgZmlsZXN5c3RlbSByZXNpemUgbWF4IC8ubW50LXRtcA0KPj4gKwkJdW1vdW50
IC8ubW50LXRtcA0KPj4gKwkJcm1kaXIgLy5tbnQtdG1wDQo+PiArCQk7Ow0KPj4gKwkqKQ0KPj4g
KwkJbG9nX3dhcm5pbmdfbXNnICJVbnJlY29nbml6ZWQgZmlsZXN5c3RlbSB0eXBlICR7ZnNfdHlw
ZX0gLSBubyByZXNpemUgcGVyZm9ybWVkIg0KPj4gKwkJOzsNCj4+ICsJZXNhYw0KPj4gKw0KPj4g
ICAJbG9nX2VuZF9tc2cNCj4+ICAgfQ0KPj4gICANCj4+IEBAIC0yMTcsMTAgKzI0Niw2IEBAIGZv
ciBwYXJ0aXRpb25fc2V0IGluICRwYXJ0aXRpb25fc2V0czsgZG8NCj4+ICAgCQllY2hvICJST09U
PSRkZWNyeXB0ZWRfcGFydCIgPi9jb25mL3BhcmFtLmNvbmYNCj4+ICAgCWZpDQo+PiAgIA0KPj4g
LQlpZiBbICIkcGFydGl0aW9uX2V4cGFuZCIgPSAiZXhwYW5kIiBdOyB0aGVuDQo+PiAtCQlleHBh
bmRfcGFydGl0aW9uICRwYXJ0X2RldmljZQ0KPj4gLQlmaQ0KPj4gLQ0KPj4gICAJaWYgL3Vzci9z
YmluL2NyeXB0c2V0dXAgbHVrc0R1bXAgLS1iYXRjaC1tb2RlICIkcGFydF9kZXZpY2UiIFwNCj4+
ICAgCQkJfCBncmVwIC1xICJsdWtzMiI7IHRoZW4NCj4+ICAgCQlvcGVuX3RwbTJfcGFydGl0aW9u
ICIkcGFydF9kZXZpY2UiICIkY3J5cHRfbW91bnRfbmFtZSIgIiR0cG1fZGV2aWNlIg0KPj4gQEAg
LTI2MCw2ICsyODUsMTAgQEAgZm9yIHBhcnRpdGlvbl9zZXQgaW4gJHBhcnRpdGlvbl9zZXRzOyBk
bw0KPj4gICAJCSA7Ow0KPj4gICAJZXNhYw0KPj4gICANCj4+ICsJaWYgWyAiJHBhcnRpdGlvbl9l
eHBhbmQiID0gImV4cGFuZCIgXTsgdGhlbg0KPj4gKwkJZXhwYW5kX3BhcnRpdGlvbiAkcGFydF9k
ZXZpY2UgJHRtcF9rZXkNCj4+ICsJZmkNCj4+ICsNCj4+ICAgCWZpbmFsaXplX3RwbTJfZW5jcnlw
dGlvbiAiJHBhcnRfZGV2aWNlIg0KPj4gICBkb25lDQo+PiAgIA0KDQo=

