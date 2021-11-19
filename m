Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0A7C433EF
	for <webhook@archiver.kernel.org>; Fri, 19 Nov 2021 12:33:33 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.90])
 by mx.groups.io with SMTP id smtpd.web11.8281.1637325210490093951
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Nov 2021 04:33:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesasgroup.onmicrosoft.com
 header.s=selector2-renesasgroup-onmicrosoft-com header.b=NdbQbjok;
 spf=pass (domain: renesas.com, ip: 40.107.114.90,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIa2tdEegqdoyDpL+Gj8f+3mQiir0b3Cs+hL+9rwWHdBgClVXmcQvVveOH2Gk7kYiieAvgbAQLCpMY316zXa28TK57YwrH1ILcFXJ1n4e4aHB8Rh6XoDlIOjQ6GHXMm5CXL30vwlvp4drEc7ig1+Ru57X09/+T1qkDnOgXAfESoAuM3xBkGOsedHJKi3OWc5t62VDAqSykfY1AMMh6Eo5qwGHNsvtF83kiZoYOVIhlYH7FV+SBkwFDz71D6sKwrnBiZLImvxpnWrJnEY3qNA5NcGYL1OR2UxEI4PNBmu60ZL1aNwIk7Ta8AOxCAjVJzgWbrKWtGXhJXJv2T5fyNNEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KCofxTUK6mlBhJGMadFqgTvL44DI7TBFE+udWu78Yw=;
 b=CHaX645tc9LEa1UCnu2wYX9NioSE8kRqyhJAsHYaIOOQswU7io9K61zSJYibosf2cLUXCUTamXea+TysVlsbSjnngZnDswjYDUrvHjrnH2W7mq9yUqapKBnKwpfKiFwlN+AiG5Hxhj2+NLmB/aAbZ9QoB2Mksi6Yu8OZOS+lfBqIAOxg3VCT6cbfkJRWTb6wkisUVTDDLsXBqjcZDEjzwan+eL3L6tN6gzTblftZf+XmuFYj3OCED6/Y5RAGHA6fn1ubgfE8o/PZshdwaAKL76pZW2rpRWS/ogA5jTVK9JCLQzy9Z5wVytLokUECF/iRxZkqVd8NOvlzHvRoCL75fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KCofxTUK6mlBhJGMadFqgTvL44DI7TBFE+udWu78Yw=;
 b=NdbQbjokT4gzIknm6iriEICVj4SxgrGWQAGWT2crAqxGbf9eS8Ly55CqCsvm3tr37y6s1PZ3rhNHUuEfWcWTa/WdnqQq6cLP4DywVEGDm8nZY0clA+Mld3H/SOSgx8BbuzWEPlhuGxHGo5MJ9uhFjEPZS3+N90FipxI+AkDGrSQ=
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com (2603:1096:604:13d::6)
 by OSAPR01MB3841.jpnprd01.prod.outlook.com (2603:1096:604:5c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 12:33:25 +0000
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::b4aa:d600:b596:8ba0]) by OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::b4aa:d600:b596:8ba0%7]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 12:33:25 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Planned maintenance for lab-cip-renesas: 4-5th Dec
Thread-Topic: Planned maintenance for lab-cip-renesas: 4-5th Dec
Thread-Index: AdfdQY0ruckuk3pKRXmKZHiU8njZGQ==
Date: Fri, 19 Nov 2021 12:33:25 +0000
Message-ID: 
 <OSZPR01MB6877CBB69FF9308D417D31F7B79C9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a15de945-a03c-462e-8653-08d9ab58c86f
x-ms-traffictypediagnostic: OSAPR01MB3841:
x-microsoft-antispam-prvs: 
 <OSAPR01MB38412612DB92B157C8346F31B79C9@OSAPR01MB3841.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 MgBSVvpzv4WFQ87GiO86ScptjqVtOnSxZjm1leY5tf6pqRaerP0jfqFzmh9xp9c3VIEP7wLSuMsMuGdrrimQUN6yC0rvcmv2IznNz6e4pJgqzfDLn3+hnJkzltLiJ4x9OUovneSsE3mLR6Q8raGcBEmCRrEt/pjBkpohsYJkJX2aBOxTwcfkK6/PSkcNhFv0suM10h125shJVAdWCisKI3zaQoKSY65Dk7CUtlZHQT2L7E8s1bhpYeQNMSVPHDw/1FYVBQx4szLA98l96LJP0pR6h/dlEyq/X5WksnlcV/uDlXAIhqYXCInqRxJfxi+lNsc7rEj4NUivkN5QBfM2nmWO4NUh43i2dWokXnmZVlXYXvnnwbvtHaA82br+MhpiDszCMuZmezktSjjVyURaXziboUw92Ch3Wkp0C+MgBbOjySg4VtEOlFGowzp/b07iWQ8CPa+usBgvGhPpL5BcIm5AtCnGs8f+lTUjEo292jdWx72FBorsswaTvyH6Sh9BaL67ZcWuwJgNU+Jjd6Q5liSO4WrifDoUfN5UzjF7ycAteCbVDOu2RXqVDGlghQx5FXh0kXPsr4awZbyjnzkoSMYGXZyPcr/1cwnMldXJnbl3OINXIeoDysrICAECM+9xiTkLFoHNvapklGzd+7YdvurcURyiPBV+otQog1j31FLHG8bCONV7aaTL+H+Nr/qhhAWR5xh+d8BXsoJ491LTsA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6877.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(8676002)(4744005)(186003)(26005)(33656002)(2906002)(86362001)(64756008)(66946007)(66476007)(38100700002)(9686003)(7696005)(71200400001)(508600001)(66556008)(66446008)(76116006)(6506007)(122000001)(55016002)(38070700005)(8936002)(52536014)(6916009)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?5ozMHsnaocaTFXgsWNJ3H/pvCSLUA+hhuByIbzSEsSkLQeKlC5/HFAcTY0?=
 =?iso-8859-1?Q?7vS6g+sXLn8YN9rkn3asl23OPA6GifB56Pa3qOBvCFdmGgIHkr5aMBNEAu?=
 =?iso-8859-1?Q?b3lZ2ZM9FCbVTIdphhSTzw6CqkysUBSrL3TPttYidYF6l2sCvWfMW+HBEY?=
 =?iso-8859-1?Q?xlDKHnkp1MGz7O3kdybKeRZ1TMQ9Te4DsuFaLMybFRsATRojFX6dqjTn2Z?=
 =?iso-8859-1?Q?coMrxX6JmtfHLpZaJ6Qn5PFcqJt0ff6jlgUJm2aZ0LE6U+ONI0GmWC90bq?=
 =?iso-8859-1?Q?t/Jc+2PuOJ0Tiwe1dEb1nIJbpfIo3uEw/po8ZfhNAJnVueNKhDkj0NkWKW?=
 =?iso-8859-1?Q?df3nUDBAg4EC5vueKM454s7cMOnqPB5QUaUGJVfmd/jP5NU+gFwAMgSavY?=
 =?iso-8859-1?Q?hcUDD58zcxpV0SQDhbRlnGdRRhDKGp6FZSV1EtIpgy/n01Jyllvy12whiT?=
 =?iso-8859-1?Q?mU+dyEHJNtpyfZDr+Tta6adrKbnH99xoa4IwcyFMTXz8JWO+plnIRtCiiH?=
 =?iso-8859-1?Q?ZKIRecTYdxogmfAIxcyEZj/GZMdKolFEWJk6hTHw2PPfIxuFRNi1+P+vEd?=
 =?iso-8859-1?Q?teqsexZhqfTqpsJ4f35A9D54tGeXYBPqK2eu8X/pmIJrPvqQ4FuHx0+Q5J?=
 =?iso-8859-1?Q?knDAms+duTHhZ4/cNfQW5+N9pIZxbY4kfGv0wEMKduPCETzwm2ITqwTrSl?=
 =?iso-8859-1?Q?tlQ1MB3feQh3T3Nq+tn4Ebd8olTVwMOfXJVVtks3hFg5Gm/7cPDzxrmjTA?=
 =?iso-8859-1?Q?jUs+c+/qVGauIBXWV2I/9Odn0EhfsIcmrO3kVeLlYxnxUk+rDTPthkyrcp?=
 =?iso-8859-1?Q?icyGa7T2WsTMKYu/E17QbDoXXkx3ZJ08fzHN+beCshyQJNnKSnHI9qLFoO?=
 =?iso-8859-1?Q?KwH93KLAvd+pvfxjYBHbB6bMqBsLmyUiKVv0UraP+1sFFyA5HgNCtw+aRk?=
 =?iso-8859-1?Q?9KK+B02FEdgrrP6VP7JLo1g3NrjangdetoSTPYb921o4L+6aQhAdgYkzUM?=
 =?iso-8859-1?Q?0UKGwzsNruee8mYQjXZNlbXz2GcZ5itcQMlxzhoNqk9sWNWL3G0Klwtna3?=
 =?iso-8859-1?Q?+jZezAk2FOl/Ags4pEQQANkviNzbf9A/cZgXYL8ZagfW0kfkQuh9GCICnJ?=
 =?iso-8859-1?Q?K8vxkTwX7RcQ/vfEUzM28S26+1ORgE74OXllren4WBDdxjU0Q8SJpBs2fM?=
 =?iso-8859-1?Q?G3e84LI2ifMhs2EPgP0dGdmiGzpRNw0Sotb4HeYd9FUJh8r0WUgx7FMOFJ?=
 =?iso-8859-1?Q?goDP7t+2acj3A1RU+AWTQxNjqmo2KblAPowIxUIKdbNikMf4+dh1ys1hDW?=
 =?iso-8859-1?Q?iXPPOFWwEQuMeSU9COojcUsul+KJ1vJ1vbmPDiqJPgjL+WdjaV5jg7yz5L?=
 =?iso-8859-1?Q?TIZ7jQ2cwjHhuNROFUx+/9EcTkP0/JZUzVULSXyhL/o2zYaJAx4JLIddU8?=
 =?iso-8859-1?Q?eo18QncSLxEH/hNBay8IyoO08huPLvqInVg1evsHu+07WvdZbFdZux8rcW?=
 =?iso-8859-1?Q?sOv2g/ZUdbdaAoNS+LlwomGnmVdKNsAJ1BHZR4VUr3UkqtfhxCxTLhBCxR?=
 =?iso-8859-1?Q?bY5HW909EVj8ruo15dSv3/SNowlQC24LlXDSnYysA76z8Jo2WJvi2WRsxN?=
 =?iso-8859-1?Q?gXkqxg1NGnx0Au3STE2600M0l9tGMCG+RfmUjBO+RyDhvKGiHYaA4YdyDk?=
 =?iso-8859-1?Q?DkYYK1e79UVBnZLrJY8n5IS2HT5yxDFC+WwCSYhKXSVRSYjvspe/ErsL7i?=
 =?iso-8859-1?Q?zVsA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 a15de945-a03c-462e-8653-08d9ab58c86f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2021 12:33:25.6535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 +D53yR341qKmOBHJf0IjMxjNrh1OESZe5Saak51vJlFWwz6MrRaZamQQnmsXw6hdtTkY/U3ozdqr3e3Mj7Aj1IwVgwxRiBjNZ1b02Mo7+n4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3841
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Nov 2021 12:33:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6959

Hello all,

Just a heads up, on the weekend of the 4/5th December the Renesas UK office=
 will be undergoing maintenance on its power infrastructure.
As such I will be taking lab-cip-renesas offline for the weekend starting f=
rom Friday evening (UK time).

Apologies for any inconvenience.

Kind regards, Chris


