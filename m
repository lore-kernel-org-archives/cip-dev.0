Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E553D358DF
	for <webhook@archiver.kernel.org>; Thu, 29 Jan 2026 08:13:25 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10733.1769674396128286872
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 Jan 2026 00:13:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=ICTVQqav;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1769674393;x=1770883993;bh=3wifWSY3ECY2sKRziHOlenD21aX4kOHLae1dY
	c5/ngc=;b=ICTVQqavBoaTSEkkXitq72ANi20zYPwc1wsZKeu1jeu0AKCUBaqatBosEr1z2xstScS
	1I9vJAWcWMbsGjMHeT1rIyjDr6w+ygumzkwiiOBN2dRuMJHaQhPxKK+opvHX4ZQEW9/WffVUZZWG5
	1ESCI0h/jnxMx/I3KkhRXpoVCwiZK+1fB3F2AyGmauRkJ56tUY1OHmJmY13TYnUw1s/RjWpZequZI
	yTJVaGZXdFiBkA2EU3Qup4B4T3JbQOpd+yTL7z/9jV52HV1/s+IR/ho+nVLkG/IQ05cCc7o4C8f3u
	DlLyUbUg7iFbwQpJyWSf2WeqgbT8WZRnagUMAUjOUQXA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 60T8DDTH3424621; Thu, 29 Jan 2026 17:13:13 +0900
X-Iguazu-Qid: 2rWhPDSx0l0pELDzwb
X-Iguazu-QSIG: v=2; s=0; t=1769674393; q=2rWhPDSx0l0pELDzwb; m=TaUBiSNDW3PzMO+LUYqbzRJKvdhoYrcdoiVBoJRrjiI=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4f1sMr4DnPz4vyq; Thu, 29 Jan 2026 17:13:12 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ug3NaWnDYDmiba3ksvl42eK7nQ+vRMK7Wg48LEKhWvy5pbFywOMvWBKXhSKvt0Dh+msWa0Sg7RDuouhAF6LICM/gVU8EB1UdrzIDXdfSfSASgCP8FXwvMto8DK4xuq7100/seUspMezm3nX4NypBgkf9F39r/lNdZNhVebHr4uE1M81HNp7s/Nq5ngjXV2GMUWZqOC4dJ07cbZeukzfKqv6sjcYn/uf0mBUxg6mGGNfYR9vMX0tlSzWPQOVfmLXnVlxK0LdmK5i3aEwT8Pp6yavO1iMiaHXyN0MSBW2jYrCzhWX52A9a3wIUMWgSOFpKZ+LZaTzVwGoCGUdpv8a/6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaKB2GI3c4hHvSPo0r23l60ofwUVVD6/7xh9MiIandA=;
 b=uVzhLJhUNYAkS9NlE3qR5kZKtkKznBbgVdM+NI3MJTIGWomhLfQXLqmrHSCUadmH+rvuY6CL/R+MVGTH1j+kg0m9ritOJgwbFzxs6U+ZtcBUhhq4r3YoGV/BriKfVULGXNS7RoW3rjJvtwcqBJsveAllOeOF5dROzaLmklNIDhU1B8GI3zX9JTCscSn12rFKSOs8rKiNrKC4xeegkNk3pRN7GDj0pOoTNacenK3UMsaSWbnBLa7rXg14351QQVN4cWR5HcX3R1toitTVQWyIziXvqmdkn4U4y9Ehei+Nyd1fF1w/EtA2MB5ZirOHeS9481tDhwdYhIhZJDBgKVzQsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <ovidiu.panait.rb@renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@nabladev.com>
Subject: RE: [PATCH 6.12.y-cip 00/12] Add RZ/V2H TSU support
Thread-Topic: [PATCH 6.12.y-cip 00/12] Add RZ/V2H TSU support
Thread-Index: AQHckFnKuEMNPjR34kq7F9DTLBS66LVozU5g
Date: Thu, 29 Jan 2026 08:13:08 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148180FC0FAD752DA0CD99301CD9EA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260128132650.6955-1-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20260128132650.6955-1-ovidiu.panait.rb@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYWPR01MB9439:EE_
x-ms-office365-filtering-correlation-id: 8a214de9-1bdd-4e9f-1c0b-08de5f0e3cf8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|14052099004|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?UnFpUVVmSGtrakx4cTVtM01sN0tudzlZa1ZST0w2eEVNVWZCRHErSHIw?=
 =?iso-2022-jp?B?KytmOC9HTFZIaWh6cTI5cmw2MjRWVS9OZEk4TkFLUmZuM3RTdFNqM0w1?=
 =?iso-2022-jp?B?UnF6Mzk5a2pvZW43Tis2emgvQTdEVGJBYjZjZ3lvK2xXdGVMUG8xQXkw?=
 =?iso-2022-jp?B?a21KV1AwYUtxcmp0MUFxNmRvc3BUWWx1S1NsSGh4dlpGTXRrc3M1WjZM?=
 =?iso-2022-jp?B?ZmRBRE5XZkdwOUYwL05WMlc3bUp1aE5NNlBkRHdEbFpWQUZQRXcza1NJ?=
 =?iso-2022-jp?B?cWZXVXpNYVlsODNHV0VxeU05bitzR1d5TmpWL0UrNXJ6MU92bzR1aUcx?=
 =?iso-2022-jp?B?QmZuWU44Z2RUL3NVWHV5Sjl6Zlg5Q0ZwTGUrcXNYWjdST3E1aVpmTHYw?=
 =?iso-2022-jp?B?OTRxTnNpT2ZNd3JJQUdvUDNNcytoYTJudWoyVHg2bldXTUtCQ2ZDdFpz?=
 =?iso-2022-jp?B?Q056YXd4S3RxbzJlTXpHTFFiMmpCL0JvVnhqVGN0SGdpMXB4QXhHQjYy?=
 =?iso-2022-jp?B?ZzVUOWxZNTdnMElVRjNSVVoyNUgxV0FldzhOVzNxbkg5N1N4emg2WWJR?=
 =?iso-2022-jp?B?Z0QwbHF4aDA4d3U4Nmo2Um9NcEJ6dTNscy9Oem5Cby9USnQ4N05USFNM?=
 =?iso-2022-jp?B?clRlT3hrb2J1SkY1NEZaK3BkWGM3L0tucU50SU1UYzhreFBFbVdieVZz?=
 =?iso-2022-jp?B?THNZMGVEeTdhSFp6OE1ieVlaU1FvUllyclpZaGpKazFVOWo3aWx4UFoz?=
 =?iso-2022-jp?B?S0U2VnN1U2VWL3RTNWQ5UTk4SG9lWFFnR0FoQmJPMWcxVXZFSmNHOUhm?=
 =?iso-2022-jp?B?c0h1SU8wZVB6U3VmNUxsNkVnSkZZNW9SZE1iZGZsSVFxTm1KT0FraVFS?=
 =?iso-2022-jp?B?N1JTd2wxaWphY2dkM2Fpd3ZVU0s3ZWVQOUJpTHhCVmNRQmx6QW8yL2dN?=
 =?iso-2022-jp?B?cUEybXZLcEpNQnpmVFg0eGxpN2ROWnp0Y0s4R2c4eVU5dmZqVWc3eWV0?=
 =?iso-2022-jp?B?elZmVVZ6d0NPdm1UUGVjRjJGRnY4M2lHM0d0WnNLbG5JZTRiL1BVZHlD?=
 =?iso-2022-jp?B?dStkQ0JhcTJ1c3hraklkNkhmYy9HU0MzbTNmbzVxUGhaVXdZUTN6ck1I?=
 =?iso-2022-jp?B?WGQ2RmtjV2Y5MkV2eHNtSlRCcXNjRGhLcm9CUmJ6U1ZwV3VaSjZPVU96?=
 =?iso-2022-jp?B?SXpRbldkcm00L0JhTTI5alNMRGRiMHJ5OHlnOFFGK1hVR3p1NW9USmdz?=
 =?iso-2022-jp?B?SExYYzhxQVRMVmRxakJ3SC9NK2R6OEEyTi9Da2FxT2ExSU5XSkFrRkhJ?=
 =?iso-2022-jp?B?NWdld0c1Z3lEQThqcitLbmhiczVoYVVaMWFUSnFTYTNDTXFRSVdGbTdY?=
 =?iso-2022-jp?B?eVhjK2VFaVU0QjdldDZCQyt0SE5Xbk8xT0pveTl6MFI2TVRFampBbTJM?=
 =?iso-2022-jp?B?TzhkcjRZVjl5bzdrRjBOZ2U2dTI1eWt2M2hMeDVHSld6SHhxeVM5UUxQ?=
 =?iso-2022-jp?B?Y1B5Qm8xYS9JQk1ITU5pbFZHT2FaQVkxRVJCNzVQRWw3ekhvVk1wREJE?=
 =?iso-2022-jp?B?cGRpWVhOZGlRUkdFdEVyODJDZ3QwdWYxcGNaTkN0eWp2bVdTUFYxODc5?=
 =?iso-2022-jp?B?bTZGUFlRWmZZVFd5UW5oWHZDUlE4bGJDVU1xVmZMNy9HcTRjMEp3R3p1?=
 =?iso-2022-jp?B?UVpRWkpMbTVYN1V5akRJVG0wME5CWmdwYkRTaFl0MFRWbkJJeHp2RDhy?=
 =?iso-2022-jp?B?T0NwNmc1bmp0cjcvOUszeU9UWDd0bHRyZXM0TVhRMnY5L2JmK0RnL3JN?=
 =?iso-2022-jp?B?SmFGeTRqK2JFQnBBbWVNdWZIb21rYW1leDBqMmJlZ2JYamdzU0FjMjZS?=
 =?iso-2022-jp?B?b2p0MFIvV2RWZ2xxS2MzYWJibC9hOEJJWW85aEhLSVJwT0ZKRVoyUXQy?=
 =?iso-2022-jp?B?ekFMV0FaZFBKTVlpVVQ5ZlRQaDR5V2p2S3gramtSTEgxSExmUldmd2pw?=
 =?iso-2022-jp?B?bGZhbW13MFJQa1Mvbk50RE93MnRwWlN4N00veXg5MGRPeXJueFk4b05r?=
 =?iso-2022-jp?B?TTdyZFUrOWdyb0NjMzQ5MDB0RDB4RUpXWkY5aVcvNWtoRnlNaXhJcEVU?=
 =?iso-2022-jp?B?elhLdTAraVptUUUycFVIR3JxZk9jN0tET21oQ0NkT3RYMEVyZGVBK3B5?=
 =?iso-2022-jp?B?bUhvZnovSVp0eGNrdDVXMWRaS2luaEV0Tmh4WWlRYVh1dEZINHFPYlBN?=
 =?iso-2022-jp?B?K21MeHRYQnBFSkpzbTJ2cjR3eU5vb3BTbDJLZ2poSTQxdU9CQTUwRVJo?=
 =?iso-2022-jp?B?bE9DdFBWZ3pNQWJ6UCtHV3lQaE52dkQ3a2gxL1VXemxuM3RlRXVhM1l2?=
 =?iso-2022-jp?B?NmROMjA9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(14052099004)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?clM5VEx0YTFrNGZaemtFdWhIL3pQV2F3R3lvTk00R2poT2pmZDhIN0Mv?=
 =?iso-2022-jp?B?N2NnbTN1ZmZTVm9nRUpSODlnUXlzRFhwZWpzMnpZVkJ5RjBSRStmK3B1?=
 =?iso-2022-jp?B?akF3T1puMDZjbzJCQjZaK1JTdVlNa2x0bjdzUjRDeFJhNHVLZStsckRt?=
 =?iso-2022-jp?B?QUpQekxZMFZkTjJBdTFrRDg2WHRxMmZuTlJZc29zc1ZWVWo3Ky9aMjFa?=
 =?iso-2022-jp?B?Y3ZKU0JmMjN0ZENTNFpXK0NwaSt6bFJ5Rkdud2RVVzd0OHQxa3IvZmdU?=
 =?iso-2022-jp?B?WUtGUUh6U1NMdW5HSEhWa25lcG00MUwyenBzUGFjVnlMa3A4OEtBK1cr?=
 =?iso-2022-jp?B?ZHBXaUJkSWNMak9oejBEWnRPMXhRZUlsMVkvRWVJNGc0UUM0ZHNWRXFX?=
 =?iso-2022-jp?B?Q3UzRXhSMVo5T1JjL1N6dThITEdRcXRMc3hDZ3I5TThNS1hUM2tXMVlG?=
 =?iso-2022-jp?B?aXdsVEFsNEQ5WlhQdVVYekhXTGpDZkZoMWowSGZWQ0JwTGhiYTFZdUJQ?=
 =?iso-2022-jp?B?cnRCdi83dGJFb3VubU1RUkNJWU0rRllVWnVtSzdkMmcvajhrNXpRQmtt?=
 =?iso-2022-jp?B?RitCdEdmR2ZYVGJTbjBTeGRPdUdyK0hkYURIa01Jcld1eU5wdUdUeFZa?=
 =?iso-2022-jp?B?dUo3UTJENzhBdGUyRTJpVmRPbnRqNzFyRmE2WlZ5cXVqQ1h3NHdITkYz?=
 =?iso-2022-jp?B?eE5Zd3ZVREhFdEs2dmh4SVh6aWJudmt4YWxYZ2RZWGtkYjAwUGFRZ1BD?=
 =?iso-2022-jp?B?cytsenl4dVNzZ2M5SWNYd21aTVVtM0lIUjg2NEt5a2dkbExDM05PUitl?=
 =?iso-2022-jp?B?RXp2VWpmWUtHV3BObnpqMkhRb2FXbGVCUGtSMEZRNFV1TURlbzNvbnhZ?=
 =?iso-2022-jp?B?blpQblc2dUQvbkRIUkdzK2FkUVpqeXdHS2tBc1kyQm5ZMEJURmYzMVV4?=
 =?iso-2022-jp?B?Z0ZNVWhUeHYrNEYwQjZ1ZVN2aXltUGdBbkhKbXdVQUpaOElNM3g4Y3Z1?=
 =?iso-2022-jp?B?ODRZOXlMWHVwRG1MSXRLMjZmL1pLRmQ3MUdIODcvRFdrNFNqNllUWTRp?=
 =?iso-2022-jp?B?VGQ1VkhwdHNBRHRvNlVUVlFLOHBPSFR3aGpsYmtkUTFkSVd3UGcxdVZN?=
 =?iso-2022-jp?B?YU51RUtSU2k2NHNXWUVQVmVuSW9yMmJVTzhmSW5Vd2xkRHN3MlQ1Z1dE?=
 =?iso-2022-jp?B?S0N0TDV4SnpWRUVjeEV3bVg1YjZnQ1JxazBnblZNWHdRa0hRTytXeDhV?=
 =?iso-2022-jp?B?eWF1Mjd3VEd1MDVrMFF4RXRjMTRTakpGSlI4NlZIcVdrc0FJZUF4OGQz?=
 =?iso-2022-jp?B?cW0zSUhUemxFZ2R1QmFURGRoSEpNK05JVVNwT0haVk5hRyszUFgvWEtW?=
 =?iso-2022-jp?B?L3k2RmY5QTNHU05zOVhqTm5OSGJkNi9sY2U4cStJd2ZabmlMc0NaSFh5?=
 =?iso-2022-jp?B?b3Q2MExDbHNZVFhhaHpHWkFYLzdDT25LTW11NTFHZzBUUXNVRXFBbjBQ?=
 =?iso-2022-jp?B?SEhhR2N0YnZSQUJEOGViN0h4SE1aUTJIMnBWdWRDNEI2elUraDF3SERK?=
 =?iso-2022-jp?B?RzBZQ2h3RHdmWitQd2NITUpiZjdYR0pCOUNDZHFYQXEvTGhsYnhIcUxx?=
 =?iso-2022-jp?B?UUtzTFFoZmE5RTlPcUxHYkY3eWllcUNWaHJUYWNPUTA3VWlHZ0FvM3lB?=
 =?iso-2022-jp?B?L0dDUzYzMkZ2QVBwaXFIb2FqYU9hOG9ubWJndWhzU29oa2Y3QS9MenpW?=
 =?iso-2022-jp?B?RGd0WW90dkNtWlIyVzJKUm0xU3lac0lrSUVIc1JFcncwNWtTbGM5alNs?=
 =?iso-2022-jp?B?UVNWcTcySHFLYkpSVlZnaGJYR3JKb1RLSlBGNkJYc0ZsRitSL0k1TEc0?=
 =?iso-2022-jp?B?cXRxSjJPTWVaWUN4dElOZE01MUwrR0wwU3NhRFRsL1dQT1JmbnBIRDEz?=
 =?iso-2022-jp?B?ajdZd1hGc0V2c1RLZXNOOVBaaVFyWDZYVFBORjRCWUFjeTV6aGRYMmVo?=
 =?iso-2022-jp?B?bkxWeFBmcThtYlhvcFkrcUFWZ09pKyt1S0tyZHF5SFlZVWtZbVM0dkJa?=
 =?iso-2022-jp?B?dmtkdnRwUUFKRnlpWVZIT256U2lQNW4yeWdEaGZNbWQzdHd3Q29yQkxQ?=
 =?iso-2022-jp?B?YWxIM3FPeGt0Y1pWZFkzR01YbWExbnMwM1dsZnd2dVNUVVk0RFNBcHBL?=
 =?iso-2022-jp?B?NUtQUitMQkNUYkg2eGNNR0x3Lzc2Z25tTXA2a1J5MG9FWG4xR3ZYNkkz?=
 =?iso-2022-jp?B?UUo2ODJqU2FjRzZFQVFMc1kvLy9UV1JxVy8yck05R1lmSHFXYUR6c2tI?=
 =?iso-2022-jp?B?SjdxMEUybDdqeFo5RmQ3SEw4bkVSYm9iSmpVam5FaGxyM0wwRmlEMUdX?=
 =?iso-2022-jp?B?K2xsQ0tFemoxLy9pcDBqUDdYTHREUWRHbTdYWW1aaVJKbDZ2cndacTJu?=
 =?iso-2022-jp?B?aWtCYWg3SVlHZGkzTmREWnVkS3gxMVo0Wk8raCt4UkM3NDJETEVhNWda?=
 =?iso-2022-jp?B?djJ3eFUxbXFsWFVzc2pBcEQramNKYnFucnpadE9zbDVpSGxpM0liYTFR?=
 =?iso-2022-jp?B?dTViL0hnbz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a214de9-1bdd-4e9f-1c0b-08de5f0e3cf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 08:13:09.0065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FJtITwmDM4mLOd3oPIG6pS+IZYT0i8cc4ZbE6W3imwj1AkeIRnmPbDnjNoQZtqWH/Z4rU4upd9Sscym5jPsVqyGPdq8iyjs4MKltLQTe6E91+Mrzjc2r2/GCeO/OVVWI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9439
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 29 Jan 2026 08:13:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21786

Hi all,

> -----Original Message-----
> From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> Sent: Wednesday, January 28, 2026 10:27 PM
> To: cip-dev@lists.cip-project.org; pavel@nabladev.com; iwamatsu nobuhiro(=
=1B$B4d=1B(B
> =1B$B>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B) <nobuhiro.iwama=
tsu.x90@mail.toshiba>
> Subject: [PATCH 6.12.y-cip 00/12] Add RZ/V2H TSU support
>=20
> Hi,
>=20
> This series adds TSU support for the Renesas RZ/V2H SoC.
>=20
> All patches, except for patch 4/12, were cherry-picked from mainline kern=
el.
>=20
> Patch 4/12 is needed to fix asynchronous aborts during unbind. See the
> MSTOP series [1] for more details.
>=20
> [1]
> https://lore.kernel.org/cip-dev/20260115083604.1064260-1-claudiu.beznea.u=
j
> @bp.renesas.com/
>=20
> Best regards,
> Ovidiu

I reviewed this series, looks good to me.
I can applyt this patch if there are no other comments and no issues on CI.
  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/229342285=
1

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro

>=20
> Claudiu Beznea (2):
>   soc: renesas: r9a09g056-sys: Populate max_register
>   soc: renesas: rz-sysc: Populate readable_reg/writeable_reg in regmap
>     config
>=20
> Geert Uytterhoeven (1):
>   thermal: renesas: Fix RZ/G3E fall-out
>=20
> John Madieu (5):
>   soc: renesas: rz-sysc: Add syscon/regmap support
>   dt-bindings: thermal: r9a09g047-tsu: Document the TSU unit
>   thermal/drivers/renesas/rzg3e: Add thermal driver for the Renesas
>     RZ/G3E SoC
>   thermal/drivers/renesas/rzg3e: Fix add thermal driver for the Renesas
>     RZ/G3E SoC
>   arm64: defconfig: Enable the Renesas RZ/G3E thermal driver
>=20
> Kuninori Morimoto (1):
>   arm64: dts: renesas: r9a09g057: Move interrupt-parent to root node
>=20
> Ovidiu Panait (3):
>   PM: domains: Add RZ/V2H compatible to PM domain detach list
>   clk: renesas: r9a09g057: Add clock and reset entries for TSU
>   arm64: dts: renesas: r9a09g057: Add TSU nodes
>=20
>  .../thermal/renesas,r9a09g047-tsu.yaml        |  87 +++
>  MAINTAINERS                                   |   7 +
>  arch/arm64/boot/dts/renesas/r9a09g057.dtsi    |  89 ++-
>  arch/arm64/configs/defconfig                  |   1 +
>  drivers/base/power/common.c                   |   1 +
>  drivers/clk/renesas/r9a09g057-cpg.c           |   6 +
>  drivers/soc/renesas/Kconfig                   |   1 +
>  drivers/soc/renesas/r9a08g045-sysc.c          |  70 +++
>  drivers/soc/renesas/r9a09g047-sys.c           |  80 +++
>  drivers/soc/renesas/r9a09g056-sys.c           |  69 +++
>  drivers/soc/renesas/r9a09g057-sys.c           | 102 ++++
>  drivers/soc/renesas/rz-sysc.c                 |  32 +-
>  drivers/soc/renesas/rz-sysc.h                 |   6 +
>  drivers/thermal/renesas/Kconfig               |   7 +
>  drivers/thermal/renesas/Makefile              |   1 +
>  drivers/thermal/renesas/rzg3e_thermal.c       | 547
> ++++++++++++++++++
>  16 files changed, 1098 insertions(+), 8 deletions(-)  create mode 100644
> Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
>  create mode 100644 drivers/thermal/renesas/rzg3e_thermal.c
>=20
> --
> 2.51.0



