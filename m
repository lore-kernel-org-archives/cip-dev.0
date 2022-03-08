Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADC2C433EF
	for <webhook@archiver.kernel.org>; Tue,  8 Mar 2022 14:53:56 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.101])
 by mx.groups.io with SMTP id smtpd.web11.8888.1646751234420023092
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Mar 2022 06:53:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=FzB5aTX9;
 spf=pass (domain: renesas.com, ip: 40.107.113.101,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEPtacupZwSO9/LKsA0yCbCVveK9QZn2EEYqey5Sln3OOPWpmApWnFyPT6NtleHLjgS2AhJBFz973oPvgTJJ1OQX0kw+9y9NFKNsR3Kq78QGghs7vWYAufa7iw7b4pWYTeGxxq2ZCclx8nmHPKEfhs/hfpiwJvOpZgLW8FhnRaoIq9HTih3+2cNsonTj2Mu0M6qQf9GsDZJFmWLkcpK5ewkkfIMRUg/V8v7S1A6XmexCkl54K4oyd5Psg8owhwRxjB9Sj7igxTq/oWwcL/6xsurj+aTQlmpvsg8kchAEj8WGHd7uqOdA5/9LymF9Za6vmtGXuasl3CWsWAs3ooWuNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCxXRZxumKl/mG1g7hogdKNRGqjL/Lnr8KvkEIVq0/g=;
 b=UugG1gBFynUJImk7nNteAd9/2/wrWzFx1fJZ62ROMFZ71CUNOaGUOjYM9XGw3+uFLxribeoeQV5uNkns/mfT+hcoHG+2CjKY71vKvtUcaGjp4WQSDC+HGcRJNG6yqc2ARHF4wz348TACjdT7rBjVOjJp3DSvPUkQtuhPLoAMwq2/fq4mbPY39pploXFYjcPhfkbodRf3S1LwtWqdyuVuDuQka9MpYn/e9ZBV6cq7s8rfIVNBwl1gQdHNg+ai4jYiKLf4G3ZubM2dVMO8kzUGCi20q5kRa/aqT5bdZQIpv0KvuqLeZUXUUEXIBPzQZzFq+1NxYLxQckypdY0LVMA8EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCxXRZxumKl/mG1g7hogdKNRGqjL/Lnr8KvkEIVq0/g=;
 b=FzB5aTX9nedxO/7V7WeVauIRjZwT04SHb/aZ4V3uqPGpP2eEng3k8Tn04TIF5afcSrOJd1IujGJuNKw5k4x/PXukI21V/moJMq3G+Qtc3fDHKfbk4D7JgTQr0d0EwPJBYlDm5oDdne2LOBfDnQXyNj3LjC3XPk6UkvuKoEUF9uM=
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com (2603:1096:604:130::9)
 by TYYPR01MB6652.jpnprd01.prod.outlook.com (2603:1096:400:c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Tue, 8 Mar
 2022 14:53:50 +0000
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::684c:45d9:bd7c:c002]) by OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::684c:45d9:bd7c:c002%9]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 14:53:50 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Adding v4.9.y-rc testing support
Thread-Topic: Adding v4.9.y-rc testing support
Thread-Index: Adgy+xq6CQjO4FHnRhabwhOca814qg==
Date: Tue, 8 Mar 2022 14:53:50 +0000
Message-ID: 
 <OSZPR01MB68776F5E350C51B188876E3DB7099@OSZPR01MB6877.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aba29af6-afdf-4c5a-e7e1-08da0113753c
x-ms-traffictypediagnostic: TYYPR01MB6652:EE_
x-microsoft-antispam-prvs: 
 <TYYPR01MB6652AEE54DDBB23D17C26FF4B7099@TYYPR01MB6652.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Jirjj3MhBXpCNdQG0cdWPrWPUOHgpQJUYL5JQKJ/folDdZXGkVdxcWqMAQECPg3+1LD4lW9AfiynefWMu22/MnvrxsLQpFVDpNDfq76+IseM+cQbJvaGsx2xs0n987jjiV8ahf4rU7yx84R3nzoGqtunfsp5H9JxSa8j3fNAXfNPJc+Ppn1ElHVSrXnhaHdTEUzzIjef+Ay6N8cfRMf01Xcxq8fwfkhklQBJNUjgyLOx0TTPOMwsxadJP5uabkEiKSPrxHYnXXjJ6QYd0b8YzK7VtwpEgUCMUE3XwOeCJf37U2O1DnRsjbDCpeX3Sa8pmVcea9gpsa5Hmg6wVr8t/CGPO/aeHzTDA+G5PrJbv+9ogzBZoJfrRv2XJX3j+DUYDE/ZVAIcQXI1hvwP5D1iwXuKct2onozoIVa658X4+eRyBi2o14xHonD1L7TWHLpgKCFdohWL0oumPJtqwiViYTb1P1MItGgYoFZn0GPFguNqvWwf3Ab9VrSZ6g/q+kLkUqr+JsZwQb+F7yTgTtVhAkG69cAmS/69e93hyyvRUd24YpZlVwgndqXLkJ/jcLcRhAkAcMeI4yqWmy/vi2uR/8Zqc0ktULlqeQQwmt6EXt7crokNNk/QBY/YChHTeB0t0OGWyNnmb+nIeJgdEzxzeiUH/EUOopUabL7YdzCjUqq0VkRDH4aM2mF/fTfUW4lxWhLiajPQojNyDlLx0AL7fVMOMV0gP8ht1Fw1QMxQLLQWA2Q3omgwTUx0draP1tiPs6Xkc2fjsDVujc0Mc5Dkb0dB/SkTosLNmmlQlKjpXfiV6Fum7XDSlEn5HfEU1lOcppjfM0Rl3ZsPIAtvLZ3lNQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6877.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(33656002)(55016003)(186003)(6916009)(6506007)(38070700005)(316002)(9686003)(7696005)(26005)(38100700002)(86362001)(966005)(508600001)(71200400001)(64756008)(122000001)(83380400001)(5660300002)(8676002)(52536014)(4326008)(8936002)(4744005)(66946007)(66446008)(76116006)(66476007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?fNQJSH2HrObZbgid+uPaVf4caLPnfOOTn19HISGlY2rFqkSM1am6wPdxFc?=
 =?iso-8859-1?Q?yX9iTcRbx9vQOnQ1p+5xM9SyQEWotYjVUM4yPQ7mg7y97nDRSbme0weyAi?=
 =?iso-8859-1?Q?DENTYpv5pV5lbF8pX9J3lfQSvTbQqplgRqmxlysL9BPGyeOa4oXVOut/+V?=
 =?iso-8859-1?Q?oGaPwEc6izgXVvmgZ0ApQ+Q2CY7fgZBZEtTnPAaDu9Gxb9GgfILk2YArPI?=
 =?iso-8859-1?Q?Ujo7fpYuAEEZHhag2ts5TWvNVztL/tv9DdfDAR+5uE3kKgTVKMIjCvaIHc?=
 =?iso-8859-1?Q?Ux4PGV/IFJXNrtIpCpVUTNNj3+6+Nm6I0SG5FLoNSNhHnwwjJCWj92ZkGD?=
 =?iso-8859-1?Q?Iz6lsn9hu2Ct2A8mbcz4xXOj8FeVd9xI0+s95LzkGnKojF4Hf7Fcq9LMlJ?=
 =?iso-8859-1?Q?um6l1gdAcKcp+s/dGpR3PupB9Nev13KNF1KVGVpTK0rcrKHOfdaK+XzLz4?=
 =?iso-8859-1?Q?xTGR8sW8Q0fnMUXPRi/DVehVWE/svLFRVZ+6YuHGeko8D5uaXDBKFlrmnc?=
 =?iso-8859-1?Q?X7KzmChjzfQyZowZxFOxPbWLNe9yWLuN/ToiuKCpwcwdRmiO8HoG6o2YaK?=
 =?iso-8859-1?Q?1qJX30LMoriLtkEU8WKuL1mLIt7lkpdFaQntosUOdKbaIxBeguR8fzhscs?=
 =?iso-8859-1?Q?VmmDDjJk+NHqVLT6nh77FMsKYxVsggSo7B0JckeCAQ2BMTm1ZRZkXYKiaJ?=
 =?iso-8859-1?Q?9Jnetrt3WYrY5AbWYybC8VVOLgR+SaWZajUiFFKBIca6bztxOe0IhkfxVo?=
 =?iso-8859-1?Q?DEAGnNDCHwW4sdr7dUju9zA1nb0JtNyvy5m9LR5VauMkO8zmvGCPTzdpqa?=
 =?iso-8859-1?Q?fgnfg/Dozmy/IJZ+l04QRbmLL749cZupk3kyAhDkZsha4yZ51Ph6Bofe9S?=
 =?iso-8859-1?Q?mZv0ZSFMPD4ebcE0jTRW+vhOhMTgohUYFFlGdZ2e+iGyRyHNxx9TjzF6bZ?=
 =?iso-8859-1?Q?M3R0LQqMkyVOR3YKMkX2QndbMc8b8dKIzz2zArPn/jxrbr+h3UgTeFXbHL?=
 =?iso-8859-1?Q?Vy+4bHiUUJ3ADg3DxxCQ5kiUXPkkUtOPjX31WneC8YMU4CK2blayN5bfSF?=
 =?iso-8859-1?Q?6Afxq1lioBEQGGAY/6YnuK00pONSiohfWpoaSmjaaIx+e8dFzDBCXKnfT1?=
 =?iso-8859-1?Q?pRFuM0nwVo51BFAbcdAIKqLdp2T9sIPVOAh/WpE1G9WK4rAfKlcAc/M7ze?=
 =?iso-8859-1?Q?VAaxM/1FhykiK+18UH27XRBruyTtPFeJyi76vQmqFMki33u2sqIIpsLvKv?=
 =?iso-8859-1?Q?sNvPqT0B23qj/4LLz4Xq60kiDRMF9DmdH1F4MX/82zwod5ePavYW79r5s4?=
 =?iso-8859-1?Q?RbrgbXNF/eSV+O05ecn3RSMLkc7vyA3kJx7wZizbiYnvx+yOC5zEXk/6KP?=
 =?iso-8859-1?Q?g3RgA2pVHWX+Oxvk2r/gXVJCpfWcJmUNlmwXs4Nvx4N+3X8C7rUmG14QzB?=
 =?iso-8859-1?Q?Ru3RDKwOhKejbF7QAo55NnC4Vm0+30F0jnEWBzAzX7xV/i46R/jPzVU2Hy?=
 =?iso-8859-1?Q?XDaK6TYar4etbEDFBSID7pFsetFcHhe6/dhz2sjayZDh0lgNonZd/jg+eo?=
 =?iso-8859-1?Q?+R4anXIudlmEiWlwWkpzJpZ6XT56t+zGWaRYxhOKsXSyci60iZkyAIb6xt?=
 =?iso-8859-1?Q?waTI+WQ+tWHC42ImSC4S1Je1j2Ls9RtS5DVdVe6Q1L3IbZ3WtsIMVj4TS6?=
 =?iso-8859-1?Q?ZrFssheTs+ORwetrovvF5ZArrHZ4ddYZlzFS85WJnmOva8zVL8DT3fOd0q?=
 =?iso-8859-1?Q?joPg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 aba29af6-afdf-4c5a-e7e1-08da0113753c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2022 14:53:50.8653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 hso/BZ7FOB2L5V0rHsh8A3UTtlygVEvraom+Tewui58ackqLHzJ0ayCS6wX+oJwlk8mg98dsNAyS8blyXGNDAz/Q1SgSmMY2RW6GOe8tTXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6652
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 08 Mar 2022 14:53:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7670

Hello Iwamatsu-san, all,

I've started to add v4.9.y-rc testing support.
Initially the build/test support [0] is identical to our v4.4.y-rc testing =
[1].

In a test run [2] however, we're seeing three failures.
Looking into it further, it looks like we didn't copy three configurations =
from v4.4.y-cip to v4.9.y-cip [3].
Was this intentional? Or do we need to reinclude the siemens_am57xx-pxm3, s=
iemens_dcu2 and siemens_iot2000 configs in v4.9.y-cip?

[0] https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-/blob/p=
atersonc/test-4.9-stable/trees/linux-4.9.y.yml
[1] https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-/blob/m=
aster/trees/linux-4.4.y.yml
[2] https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelin=
es/486998446
[3] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/commit/e7=
37c5ec22d2b7d3220d83855a952340f2357636

Thanks, Chris


