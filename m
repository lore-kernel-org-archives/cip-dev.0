Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C7FD172B8
	for <webhook@archiver.kernel.org>; Mon,  2 Feb 2026 02:09:24 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.43884.1769998158751867432
 for <cip-dev@lists.cip-project.org>;
 Sun, 01 Feb 2026 18:09:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=bobIvvNl;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1769998153;x=1771207753;bh=Xrje0nZKchiod9HGesYXmcWDr/UWFTNUfNjcK
	qKKn/8=;b=bobIvvNlPOwX5+s422cAy3QmBVm1wRv0wFOBQy8DhQWOW+nblJJLBp5mbxrJqv0iFHV
	OLFPKNmrpjl470oSMfGpevJ3uVGGX/+9uQ+DL4EMQghiAjnjNA6aj7g/a+ydl6Ft5ZUQaD8ITfux9
	q/vMSXXFDuin4XJG4t0ZWdj5QcDQH+kpxYlroZitauWbHiRflK6SWqwsgq4cdhUREzBd/8T+2HuPI
	IAaWOw+0cNgT7Q0a5n/TZLCKmMoBeCbs/NCbFAmubH8I+vIxVMfNRDtyzLU2lpO8o4Xi86cliQBj+
	pQ2p180pNK3FMZCTD/55BJgzfIA8K4lJESvThWBxTxUg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 61229CL03588510; Mon, 2 Feb 2026 11:09:13 +0900
X-Iguazu-Qid: 2yAbkFyyImKJjHSPUG
X-Iguazu-QSIG: v=2; s=0; t=1769998152; q=2yAbkFyyImKJjHSPUG; m=sFbDL8BCMQI4O5104GmApPKRcIEVrhAGmj8Au7Yw/zs=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4f49603n5fz1xnq; Mon,  2 Feb 2026 11:09:12 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j8mkT3pSDRUtBsBZ5uUJCMuD0A4XVOgSNrdTLxyvgbe6FkcZWis8Umje5IN7h0HC7LLH8x+2rkJAYoWb/GTknN8yzCxFBhFmzJvPupvLz1rJRnWFmcz5yoRKLFZ27v/X8+53b5R0IJK+lKaoheE45/bQiCeROu2NCXouyhCfjGUSaOPyv6vSg6HL+cHmFwA9WHy+trI6tqJ6Z4ql/dDaGw7O4m5fbTnNRHVF3TpafGN4EU5nLjkD06Hq6hOoqZalT+0kHm216rbpsS7/06Hx8KC38fJndwHT0GCC8eOZRpsjRRuazGgXqLo6Xd02fbrg5yx9GGL+LDm99WGvOK/kBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdhYsPe0hDhzndCgYlIBZmpEG/74Pw800uoKsQ+K9T4=;
 b=ma5IfiZSsqqavTm1s4KpPBBsCFNgDftpKo6U0SNMKK6O1j0LIKWiOlopdXdVGQskvTQHr//V+D1+pVIkO7tr6OlgCOYyoEr/QDC42phyITXuQdBZXW0Hcf7cE7m4exzpn2PaLEp8CpzsGCpX8bDtUovaQQGrBkYGYuHoqfETX6ntsdp4DIc1bwekkWj2D64ORBJQuHLdkvOsM82BkI5BBAXsVEWFqsIDS0H+VgosLTDwcx2X8/DtvM9yi1VY5YwCyL8r0FH1e7VGppcs3Y/J4OrmN0AlGRfQszPqk1/bVR/A4dINcMEogl4cPfoXwbQdnyjOumFwbrfBcz4QymTnkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <tommaso.merciai.xr@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>, <tomm.merciai@gmail.com>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 0/4] Add RZ/G3E DMAC support
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 0/4] Add RZ/G3E DMAC support
Thread-Index: AQHckG9d3mT9sVmWVkqBSD5lnrTD2LVn+eiAgAa2quA=
Date: Mon, 2 Feb 2026 02:09:09 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818A6B303E317CAA232942ACD9AA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260128160048.1445926-1-tommaso.merciai.xr@bp.renesas.com>
 <aXplOU/fgckpEbAT@duo.ucw.cz>
In-Reply-To: <aXplOU/fgckpEbAT@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSCPR01MB15972:EE_
x-ms-office365-filtering-correlation-id: bf506936-6e59-4b49-4cb0-08de62000d6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|14052099004|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?RUxKZXArM3JkNXc4cUFkbEZrdmZhVjRKa2pvZkpmTlIwc3k3bFdOTE5K?=
 =?iso-2022-jp?B?eitvS3VmZXpZT2N6VDFMcDhrZEZPcmd4S2xxVU5CdE9SQStQMjlVdmRh?=
 =?iso-2022-jp?B?K3R2YjI3Ymg4dy9JdXdZZ1hKUUd1UFhxNldpSVdIc1k1SFgyUHkrN1hQ?=
 =?iso-2022-jp?B?enVEWmRGMjBIdzdLTXlMcTFEdndSOU0vUktScFM4c1FFWitxZzNrTDM4?=
 =?iso-2022-jp?B?MmhINzFCMVpDQ1VFM2NXUm9vdWltRGFNWlROWEdEaDMyekNPV0g4U2s2?=
 =?iso-2022-jp?B?MVNXTWtrOFdGWC9uVTBhU3g4YVZjZTVlZFFnU2tnR29JVU9EcWJ3em9X?=
 =?iso-2022-jp?B?Qk1rTUFDOWJDbHI2Wi9qK1ZCQStJa3N3Q1grMjNzN3pwVm0vRnpUZi9m?=
 =?iso-2022-jp?B?Z0Q2NkpFSGVXNC9MTGdzL0I2L1hadlFlYzZaOEx5cUdXcU5mWGJza2Fm?=
 =?iso-2022-jp?B?dnFXeklzNWxCcW5vbTk3MWRWMUVqSnR3Z2VucC9EaVZRSlRBRDNucXho?=
 =?iso-2022-jp?B?NEZ3bERMc085Q1FPMURESUJQR3crVGVaMTcyNFZQcnpzMVY0WGJrU1k5?=
 =?iso-2022-jp?B?aDI3MjAzVFd6cEtaZ2lpM2NsMGxDMERFYXR4ZUZOaU42M0xUaEs3cnhI?=
 =?iso-2022-jp?B?d1dzdHlTQ2NSQnJtVFdubXNJVllMTHlHWGRQMGY4cGJ0dWtVb24xMkpG?=
 =?iso-2022-jp?B?Mkljb04yUExWWnllbE9obEt1UlFKazRaakt1T25oMVA4dzF1N3dBd0RH?=
 =?iso-2022-jp?B?V3pSWmRtYnh6aHQvRU44Sm9aV3p5dUR6b3A5eWx5djFma2hNcTJzbkZU?=
 =?iso-2022-jp?B?QmxHSGcxTERTYlYrdTBtT3o0T2FFNzB3NjZ1bU1kMVVXRWt0SC9tNEJt?=
 =?iso-2022-jp?B?aDBxaGJZcXFzOEsvSE83eWlrOGFJM3JtNHcvbDJVN0tqbnRxSlpvTUJz?=
 =?iso-2022-jp?B?cm1sbFF2KzVuMEl0OEpLbk5zOEJTV3JDeFBrQnlybHlIOHFwNEVac3k1?=
 =?iso-2022-jp?B?aWpUR0JPNjd2ZWFiMlhkWXNOYkJCWlZKaThNSnJsbWpUWEt5WHBJSHNP?=
 =?iso-2022-jp?B?cXY5MnNNSXUrbWpkZzB2V1pzSFVRaXcydmVlVTg2OWovVlU1ZFVZOFhx?=
 =?iso-2022-jp?B?b255cGRjTHZJZGczVUE0bmVLbGo4L2ZEQ3hZTkFDeW5hMlpjRG9GdU1n?=
 =?iso-2022-jp?B?cEpXZHdodmpDcGNQZ1NxNndqaUNtMlQrK0I0dlp3bVl2TTJ6NnJmQ2Ja?=
 =?iso-2022-jp?B?ZkxzbWJnOFc4amFoYk44R2pvZUNMQkVKbTRKSlZHN1JpaWRCakY3dWNk?=
 =?iso-2022-jp?B?eFZQQnNoNFEzWUVVWU0yL2ZHY1A1aW5BQWtWcVpJaWc4VTY2cUwzUWpn?=
 =?iso-2022-jp?B?M25ocUVkTFFjRWxrbnl1bkJvN1lPdDlGOGFtMGFtMVU4YklRVE5PZlZB?=
 =?iso-2022-jp?B?U3V1WUd0Z0x3dTdGd1BQTWZnNHhENkVJdExWOFhGR3Z1dnQxTzlnM0xU?=
 =?iso-2022-jp?B?MURsK3loeGlWSE1BQ3NqUWRuVGhsYW9iMlJSdFpDS0RMU0l0aTQvdWdN?=
 =?iso-2022-jp?B?cEFBMFd1cExiV1lXbkhzZ3R2cDRlZE9UMGUwcHl2elJHNXVsNkdIU0xs?=
 =?iso-2022-jp?B?bFA2clgxWm9YVzdLMFJXMEU2YmRrY1U3NzdCbGhlMUYwU2g4WC9ZZi9p?=
 =?iso-2022-jp?B?M0xpWFRRTXNPQUdxa2o3TTdQa1M0WmdibGlRY3BnbjVJMHZMMkFlNUtB?=
 =?iso-2022-jp?B?bUdBSU0wbm5NaERFUlhHVzVValM1Y1VuNHgyNXdnYkJOWXhiYmxRZGdJ?=
 =?iso-2022-jp?B?bGF0SFJTbWo1SEt4clRudWE0RGpYWkxaczk4VlBaOVY2QWkyUjlSTlVv?=
 =?iso-2022-jp?B?UzZ5anVaY2JMSStPRXlVdE5qVmZ2ME5jaFpTWFM0aFFLM2lrcXRvczRk?=
 =?iso-2022-jp?B?VjJGSVZXWEpPbE1wSlY1eHZUYkRmTVh5bEdVTWJoZXhWa0FMcUtxZmJi?=
 =?iso-2022-jp?B?WURnU0dUd0VFWDFVakxtRFBteURZeXM4Y0cxUG9IN1h2ZGZtemlCS0Uw?=
 =?iso-2022-jp?B?VUxQSnloNzI2OWlENTV3OE01U2xNdU9uZi9xRXRnblVwOUNVMGpKaFcw?=
 =?iso-2022-jp?B?VGtqMXpKNUF3ZkkreGZ1MnZMN3ZjNkxmUDRWRGRxOFFyM210ekZjOWtL?=
 =?iso-2022-jp?B?ZzFNbCs2TVIyMlVFc3Y5ZG5UY1k0RFVuS3hXUFI4OXMvTEF5c2s5aUM5?=
 =?iso-2022-jp?B?UWNWd29ycWVwOEJSU3B0U2hES3RPOEZrK0Rxd09nTnloV29YcThleVor?=
 =?iso-2022-jp?B?NGpPd001ZEMzMXJGN211VkI5ZGlOdVprSmlGSzNkVXJhS3JUWjg5a25K?=
 =?iso-2022-jp?B?M01WaUk9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(14052099004)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?QVRGVEhmN2ZNaE5ySHc3UmxOV3NTVUNLdlZENlllUEcvcWFnNmJWMW0z?=
 =?iso-2022-jp?B?SXZ0UVVIR1UzQUgzcHNtaFVmd0k2emY1ekdJcjNCL25aaUZkUUREU3Fu?=
 =?iso-2022-jp?B?NFl5Zm04eGNnSGZFcStnRTZkd3dRei9xTDVJZXUwRGJWd3NScnBHaW5r?=
 =?iso-2022-jp?B?by9xL3k4TkptcnFUV21tbUdkR2tsRVJVb2hiVGZFS0ZlYnMzRUhLaVRl?=
 =?iso-2022-jp?B?RVRsY2JLamUyY3ovZ3pTWTdqdzJWV3lkckFwRlJYNTk1c0d3bnVEcno3?=
 =?iso-2022-jp?B?VTMrQkE4MFk3K0tIOWN0NC9mU3V3TjF2UzNPL3NwL01wcS9mS0s3VjU0?=
 =?iso-2022-jp?B?WW9yaTRxQXFRTlBBVHYrQ2pNQlhuNmZiMHJjVVFRcTB1RDdOSVZrVHpy?=
 =?iso-2022-jp?B?NlJRK0J4ekMrK1NFdnlqT1p0OTgwTm5QbHI3dlJTQWhRdC85clo5R1Fu?=
 =?iso-2022-jp?B?ODF3cDNSWVNvT21OekdlalluS3k1UVF4M2V5TGx1akYrd2thRnh0K25H?=
 =?iso-2022-jp?B?emxicG00Q09Ua2VwaGpnTjBqUGFrRjZwUkw2VTN4c1VqeHg1cW9hcGFC?=
 =?iso-2022-jp?B?NTNMdmYrb2VCbVdZQ1lVSTRIZ1dqbUlCVnZCd2dBNmRGM0FTV1NCd1RT?=
 =?iso-2022-jp?B?UWpHa2d6TDNNQlBHaE1pcjFQeUYydmU1RjVuUmdUNmlqUlZBS21rTGYy?=
 =?iso-2022-jp?B?NzJaWE5Ec2dLeUVkTXNHOHdKeHBBNjRXeGIyMFF4ckpndnhHN3E4aHhC?=
 =?iso-2022-jp?B?ZFNYK3RwNXFJMUhaM0dmUVlxVzV6VHBHeE1ZZjRsRnJ4dllZK2JMTGRD?=
 =?iso-2022-jp?B?QVpQVFRjQjdORGg0QlJnTUVoS1VDeWoyM05ZMFFSeG1xc3VnZm81Qytl?=
 =?iso-2022-jp?B?UElsSzVKYlpvcS94czFYM2haUXRFMkJoU1Q4K0N4Qjcwb0N1OUdRU1lT?=
 =?iso-2022-jp?B?ZWJpT01nZnRQVkJidjhDbzFFTjNWdVgxaW52NjZ1Umxld2haZUVQK2do?=
 =?iso-2022-jp?B?SjdsbmlJeElNOFB0ZmxuVDdwRmFMem1VUk9LZzlZM1B6MFVBVU5hWFlj?=
 =?iso-2022-jp?B?T1RBWGR1dkxtRktYVm1qa1lFWVBCNTJLY2dod1JaWlZzaFQ5MXZlcHNq?=
 =?iso-2022-jp?B?eWNqdWVOeWo0M05rM0hSWEhEbE5qRnhMa2U0QTZxcGVESFBIbEM0dE5K?=
 =?iso-2022-jp?B?cDAxd1JHVDdnYVdWRnBkNTZQbStOVEc3MHlkVC83b1VjR1hLNDZYL3U3?=
 =?iso-2022-jp?B?WjJRaUh5N0lmZVhzSVppTHpCRW1xY0Q2QUZGbUcxS0RSZkdpdldOTEFL?=
 =?iso-2022-jp?B?RjFyY20zcnB4WUVrWFhyUldFZWk2dDVQa1d2SFdwNW9wc1ZYbVZ1djdh?=
 =?iso-2022-jp?B?ZHNtcEVLQWpSellSdGFVb0xOakI1Q2pIbWVrc2hpcFhicXg1ZE1uWnlK?=
 =?iso-2022-jp?B?STFuZ0daNVhTaFE3WEpOWXNSMkJpN2owdU5tcnBza2JNRVRnOFU0dnoy?=
 =?iso-2022-jp?B?MmluWkZEaWFlSVlYUDczU1JUNGNGTFdKSEJsT0ErZkVmSnpQd2xxNFUx?=
 =?iso-2022-jp?B?QWpydDdNTElrSVd0aVV5aVFIdnlIM3JqZS9aaEZ0alQzZDAzVmhWMzJm?=
 =?iso-2022-jp?B?dUNuUmh3V1dtWnRMSTVNU1BjdVNIVDJzK21IalVPMlNKWGJUOXZzMmFo?=
 =?iso-2022-jp?B?Z3U0c25MQkRiaWtKZVBtZERiQzRiU1VlU0ZCbS9qVkxkVDV5bWxVWm80?=
 =?iso-2022-jp?B?Q09MNTNJSVV0eldNUDFpQ21wYXJDWFp2YmZQOWRBT0llem1lQTZkWUFD?=
 =?iso-2022-jp?B?SXVxdzdhN0ZEZzR1VnpuVFdTandwOExzalpEK25ZYTdxWmJvUkJKZFVZ?=
 =?iso-2022-jp?B?c2poYWpOVC9ZSVQvK1o1OU8ybFlod1owc0lDSDMrOURRa2R3dzNLMDNR?=
 =?iso-2022-jp?B?dTBublBLcmwvUmd3YzVvbGF2MnBYMkU1N2ttTTkzZ2pmYlRaM3ErYUh0?=
 =?iso-2022-jp?B?ZmVYM1JtazVneDlXUktSeXFVZkt3TmZGMDg2aHE3VU4ySll2NVoyckdn?=
 =?iso-2022-jp?B?K0NVWnE5QWZ2Q2Ezb2dCeEh2WDFNTjQxTVJDcVp6NTNESU5aQXduSkxS?=
 =?iso-2022-jp?B?SmtpaUZjb0ZhdGZpeHpacHdNMmw1TC9DSm9CK2xRc2ZoY21zUjk0M1pH?=
 =?iso-2022-jp?B?UWh4VUhnRHBySFYzaWovbVRtODByZG9lMEpsSHg4QXBSK01Sd2lGdUM5?=
 =?iso-2022-jp?B?K3ZYakRHRzZUUWU3RnI0bUlMaUpNVzY2cjR3dlZMSGIzb1FkS0lIUjZH?=
 =?iso-2022-jp?B?ZWo4SE5OMkpxV29HR2oyc2ZOeStqYVRKdUh1aUQrenRJczlOTHF1Sm5D?=
 =?iso-2022-jp?B?ekc3K2pBbStRWDNFZHVTaXZXR0oxLzBDZnpVVGVOZjJTSW90ZW9rZjcr?=
 =?iso-2022-jp?B?TUVhZ2N0RkZYMVZxT2JFNmU5TUsrbm9yNytjZGJ6YmFOQWZLTGJDWE9h?=
 =?iso-2022-jp?B?TlRLQmdHQVRFL29BOUFRWUdHM3kvc09mZmlZSzhUUlNhODlKZHNkQTZH?=
 =?iso-2022-jp?B?ZVNkaG4xOD0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf506936-6e59-4b49-4cb0-08de62000d6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 02:09:09.7265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R2Zrcr3n/0F7o3pXmTE5+Qa+kbZ1ra+rP6II9MTWxu1WhQBY1SfncL/Mg4guMD1nkWw0DZrMTBbiJ1s0Ao7ykYM1EMxQotQ/al5HQ6sE6ypzZMOwHnXIIqZXchMwULzl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15972
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Feb 2026 02:09:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21795

Hi,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: Thursday, January 29, 2026 4:36 AM
> To: tommaso.merciai.xr@bp.renesas.com
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek
> <pavel@nabladev.com>; Biju Das <biju.das.jz@bp.renesas.com>; Lad
> Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>;
> tomm.merciai@gmail.com
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/4] Add RZ/G3E DMAC support
>=20
> Hi!
>=20
> > This series adds DMAC support for the Renesas RZ/G3E SoC into
> > linux-cip 6.12.y-cip kernel. Backported also commit
> > e57389d5547ee24b472ac5c8f8a7dc21b063ad73 upstream on top of this
> series.
>=20
> As with 6.1 version, this looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.

I reviewed this series and 6.1.y, looks good to me too.
I applied with Pavel's Reviewed-by tag and pushed, thanks!

>=20
> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


