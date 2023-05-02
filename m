Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6547FC77B7E
	for <webhook@archiver.kernel.org>; Tue,  2 May 2023 14:07:59 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.115])
 by mx.groups.io with SMTP id smtpd.web11.519.1683036476694097177
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 May 2023 07:07:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=jDXzN+7w;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.115, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJEqJaqCncD6lKjM4iWkvSPojf4hyuo4jB3GkMJouE9BgmEczJ+H3Q1dDt+K3J0Ss/xcfYm5I+j9gxr4VKGZVs4Z174bxSWiTQV2hIkLofbSm78A7vLWmMgYpSUJWxKk6Xrtj/2jTki3klnwagBr47GjbkwVspmPw8tbl75wYyRTGF/CjmjR5k3n3sqC+NSWNLMpCYjZggpowrYhUTfZDOJMThh7csCOyMuo8X7V0AzH256NKODk5yhD8J70lVrhfJygE92hHCpADpTVvKLu3NUAMkY6t2rROgbOZBncZ1AfY/fxVf7AZ3n+3MuI/YLjtliMbLz6+TCFGUb5zU7clQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PX2wTPC96UErqNvS4qe4vBITED0RdtizKtxEpVv+tmE=;
 b=Ua5iwEaiZULOr/7EgCLT8qt5lZbN2B993wXKenpPhVcY9havUNda0UJtg8796rx69j1nNwr0H3bgRQ+t/76sLglFHABp7u0VJD4e80cUuPRPo4fIgZpmqklNXTXXO65exsrwf7kT8Hd7IT0y9EuAqIJ2fOfocGUdrJBG0relfNEaDhZ+jUM4U4ws03Udd2SbIKLr8nY4TIr3Rj3UiJvzwUxlnsUie8SwMdhAGfSUIVAwoRcn24nFQtB+lbU4S/0Hg66TgACzxBh7Gbvta8EqyDtBAVWLh99UZ8utANBNBfEG9D6tq0dA+ryH0qfnkOoDzQOIIFKkh3/dJUK3q46YZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PX2wTPC96UErqNvS4qe4vBITED0RdtizKtxEpVv+tmE=;
 b=jDXzN+7w+l8wbESuOh1Xf9L83FBRaE/lDTSKU7yWT80QgGdBaM9X8QALL5QNap3hHWfXZmR1XulVBnXdPjJQBRML6U0fFTnOlr23FwWyj5mSw1kbKLtRf7q53GIkq2p3WHLBopZlhLRQ9ym2R30hSDseC8OJlupqg0tsu5FOaV0=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB8346.jpnprd01.prod.outlook.com (2603:1096:400:161::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 14:07:47 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%6]) with mapi id 15.20.6363.021; Tue, 2 May 2023
 14:07:43 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Build error with make all_sources
Thread-Topic: Build error with make all_sources
Thread-Index: Adl8/wPXGZ+peCWWR+WwQ17R2+d7Ng==
Date: Tue, 2 May 2023 14:07:43 +0000
Message-ID: 
 <OS0PR01MB5922503DB21917E7463FC527866F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB8346:EE_
x-ms-office365-filtering-correlation-id: 5852c7ae-fe6a-4498-5d70-08db4b16994a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 rTuEZWeLRQXj3SUSIVE5w6fturEYCeoTKm7aZRPibr7mBYYGa4EITREfdCuFhbmPwvMrR640ampAroN4qDFc7PoWuRHpysZfZzvRav88qFyTzl+bgxOHgOO4cqzIudn6I/VkoGKx+NoPcY1quujt+kKUb1+oo8QHAsRzvdHsi2ZnajzDF4dQfxnRw/Ozn4Jb2DRymj4Uye5u5U6wDn3mfBWTY2MP41epnUx+SI3p+PyLqvj2Gy1NLJe9hTzkEPlJ73SyC8kT2wJB7ML//5jQhTpcVnUG4HDv8LhjgXuUKxvXWiVi/wdz4gN1fqlJEG73ivuSxrY80joBb5cNq856LQYA6xv4xtINnPnLLSoAfoYFUrtbMzBu+kuYbwkNsIH1k5fVaTjIZFlMQ3eJ8VnP7TKQsykQZhnicKWLEQV/jBLUIF6p+1xzQYbaRgeD75+57062Ab8mhwdKRlGG3f6Yi1+aP2B5plboiFefVW1fiDy2t8GmoN32ZgFi1lZjh+Vsbonn42pTsZob8Go73JJ6eHsjokJdUuW5tvrh0Zv6LcQKMFaorQOqu3JYcdiY0omBnqZqKrvHAxcPzuJali+/Gs4Gi4HawRJRN30dpgf/CqZUgWc474Vb5Dk4tiYYkJwg
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199021)(76116006)(478600001)(7696005)(6506007)(26005)(9686003)(186003)(5660300002)(52536014)(2906002)(4744005)(33656002)(38100700002)(122000001)(66476007)(66446008)(64756008)(66556008)(66946007)(6916009)(41300700001)(8676002)(8936002)(316002)(55016003)(38070700005)(86362001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?lzq4iRZW2HCWACPCjogKKAe116ElIYHXXUrfRKjdvnf5c+FnAAb2EeC4Jv3a?=
 =?us-ascii?Q?rNZ6zpaecl3l1EDeUsIqp0lrNfdtOQTBM5AGFEdWqT5tjjuZBNAqc5oZ2Zu+?=
 =?us-ascii?Q?mP3oqk+jft5lmcrCtJPGpPzMSlzLCn1uPt0YD3TawhGmS/tzhWW+xMKvGLnG?=
 =?us-ascii?Q?ayterEgTJxbNAvdQ68xmAUyYpS7nxnTslUMIy+tNmyPsYemhi3aTrjaTFqz3?=
 =?us-ascii?Q?ICnTFJoRNj4g8/x27Is3uf+A1iihGosr4JpZToIMqUlpOzAHA1TzyN48CnRd?=
 =?us-ascii?Q?RIficqa34pvRrxcIIFrVl+7Vw5sK0A1juqGll7VRrIsfVeqFWRF3TY7OyDpC?=
 =?us-ascii?Q?sHyLYEQkPKPuqCSooUaLtHqFCIMMjJblVqZQtHgSMDBATcQbvM1KEmvVv1nF?=
 =?us-ascii?Q?qH56TrunOCMJWmW26o3yNiKEN+stHu9h/klYpymTbKiTVJnWtu2QPHw5gAEU?=
 =?us-ascii?Q?slg6Vcmb7oR24uXXY0qmqz2vYrAYkbLgAtwLWhYuIeUMozKJaD8mI1EKIQEG?=
 =?us-ascii?Q?8tlIZ34mfhIZlNUWO1A4qm/DUrGi7ExMG6ksmWKT85cHK8phLbbTwufTuhI8?=
 =?us-ascii?Q?rVk7z+uxNkp19ia5UrAqjLWHGD742trWU4xd2UIgUEi17yOZvw2E3f+P2wzZ?=
 =?us-ascii?Q?/zCvYbc1WZEZNUEWHHb92tvbHmnDyD1KSVHM6JEwiIVBuBKmUWrrQARwFJqb?=
 =?us-ascii?Q?/7T0Md4hANlFzoZ7vIiNc6wc2xF+VaOpCEH+yrusMJnfQin+Ogcr7AQhnm4w?=
 =?us-ascii?Q?HtCufHDcHbfH5ODQFiLfyUfZDYi3xkkydXdvsX6V2GKX4Ir3SDzT5QWRyrpI?=
 =?us-ascii?Q?+8tqQ8sRuzCFUl7Iqq0dxLlzb7/+Nk6k17PTIbV5VtjNqQ1FKjmFQGREQUX9?=
 =?us-ascii?Q?Zz4klBRVwS7GazIcgcuyAwgL/QAfSXhxDvKmCi3jbrgT/wfZaD0+3ak7XYug?=
 =?us-ascii?Q?UY3+K1jnvJ05eSy7o+eXoCrCgZ3ZgcUlL5nKR5nxu9kZRS0jg+MkKhB1kKKC?=
 =?us-ascii?Q?0MFdRXWhpG1Xnrd+0tf9NKMJIOWtb49GBJJo9iLLL3aLrLPvA2zYL+GnPO99?=
 =?us-ascii?Q?+TroTYd/dWG9wexZScnTERWdtgh2OeGYvdTHryQ5XGTBj+XzmKydxYaGkDa8?=
 =?us-ascii?Q?cdXhrMMJW/Sr2IPsCeC2mEWhp7hYaUEfEtWuCuoSWD3d03qbwiHWRDJxfGi+?=
 =?us-ascii?Q?CBLxEuhZhhmSV7LAkdcoUJAhOVsFTAxBYOX0CnF3a7WcKR8PPZm9sk2OJnq8?=
 =?us-ascii?Q?a1hL0tD0aEJqgFxgLq8Ip10TR1lIf9n9EDCreZ74fHINjvwfeFftoDrNLTxh?=
 =?us-ascii?Q?bHaN3c/CNHvqOHgO4XuJW181qXc4BvVSUAt0cmEOZXi03xCjnmy/YEsGjDPZ?=
 =?us-ascii?Q?pH7gWA+rUIlKOJp3ghRclBvvwZzZoRhE3PidqbpohODkaizaqQltn8TK5etH?=
 =?us-ascii?Q?T69sKS1d0tEzV0BW/MFEiOcYGSikP3Y8rbJov7vvWC23HoyOYGiTC1J1aGYj?=
 =?us-ascii?Q?AIhtzbKvDYiBb8+k25xazN3UXPYRSA20Dxkr0ZMG5UWr8fUqItb8Z6TvTKi3?=
 =?us-ascii?Q?+gdUre/21sbjQs2GlbOrVFHGiCAgK2SPVlB0Vq27BRB4kh1jreKODhHlxxnq?=
 =?us-ascii?Q?cQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5852c7ae-fe6a-4498-5d70-08db4b16994a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 14:07:43.5709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oP1qLGEVWW+ANJAYVh9DPzdCw/onj8kSrFOTzZBnJ59I5nb0LFy+ESMpaQY5665P1LZv7tl/2pTqUB45XCVBV0/cGkklANuhCWyti/dVErk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8346
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 May 2023 14:07:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11379

Hi All,

I am seeing build error with make all_sources

Q1) Have you seen this issue? As per the log it is trying 4.14.y-cip/arm/mo=
xa_mxc.config

Q2) is 4.14.y-cip is valid kernel version for cip?

steps to reproduce:

1) git@gitlab.com:cip-project/cip-kernel/cip-kernel-config.git
2) execute the command make all_sources

make all_sources
cd ../kernel && git clean -df && git checkout -f && git checkout linux-4.14=
.y
Your branch is up to date with 'origin/linux-4.19.y-cip-rt'.
error: pathspec 'linux-4.14.y' did not match any file(s) known to git
make: *** [Makefile:51: 4.14.y-cip/arm/moxa_mxc.config] Error 1

Cheers,
Biju


