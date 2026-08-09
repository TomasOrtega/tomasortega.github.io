---
layout: default
title: Highlighted projects
description: "Research and side projects spanning distributed learning, formalized mathematics, coding theory, and space communications."
permalink: /projects/
---

# Highlighted projects

A selection of research and side projects spanning distributed learning, formalized mathematics, coding theory, and space communications.

## Decentralized online learning without learning rates

Tuning learning rates is a major pain point in online learning.
In the decentralized setting, the problem is harder because nodes must coordinate with one another and may have different optimal learning rates.

In [this work](https://arxiv.org/abs/2510.15644), we proposed a decentralized online learning method that does not require learning rates and achieves sublinear network regret bounds.
To do this, we extended the [*parameter-free* framework from Francesco Orabona and Dávid Pál](https://arxiv.org/abs/1602.04128) with a gossip consensus scheme.
We also developed a new betting-function framework that is easier to analyze and that we believe is of independent interest.

Our analysis requires a linear gossip schedule—in learning round *t*, we perform *t* rounds of gossip—to achieve sublinear regret bounds, which is impractical.
In every experiment, however, a constant number of gossip rounds works well.
We conjecture that the linear schedule is an artifact of our analysis and that a constant schedule is sufficient, but proving this remains an open problem.

The code for this project is available [on GitHub](https://github.com/TomasOrtega/Deco).

{% include project-figure.html
  src="/assets/images/decentralized.png"
  alt="Decentralized learning cartoon"
  width="220"
  href="https://en.wikipedia.org/wiki/Federated_learning"
  title="MarcT0K (icons by JGraph), CC BY-SA 4.0, via Wikimedia Commons"
  caption="Decentralized learning. Each node can communicate only with its neighbors; there is no central server."
  credit="MarcT0K (icons by JGraph), via Wikimedia Commons"
  license="CC BY-SA 4.0"
  license_url="https://creativecommons.org/licenses/by-sa/4.0/"
%}

## Privacy-preserving error feedback for distributed learning

Practical distributed learning often uses aggressive, biased compression for communication from clients to the server.
Guaranteeing convergence, however, typically requires client-specific control variates for error feedback.

Per-client control variates undermine privacy guarantees and scale poorly with the number of clients.
To address this, we proposed [a framework](https://arxiv.org/abs/2512.22623) that uses previous *aggregated* client updates for feedback.
This permits highly aggressive compression without the privacy and scaling problems of client-specific control variates.
The open-source code is available [on GitHub](https://github.com/TomasOrtega/CAFe).

{% include project-figure.html
  src="/assets/images/mermaid.png"
  alt="Aggregate error feedback block diagram"
  width="400"
  href="https://github.com/TomasOrtega/CAFe"
  title="Tomàs Ortega, aggregate error feedback diagram"
  caption="Compressed aggregate error feedback block diagram."
%}

## Truly decentralized learning on directed graphs

Decentralized optimization algorithms typically require bidirectional communication between nodes.

For directed networks and non-convex losses, existing algorithms required each node to know how many listeners it had—its out-degree.
We proposed a [line of work](https://github.com/TomasOrtega/DT-GO) that avoids this requirement.

The framework also naturally accommodates network delays: we can add imaginary nodes to model delayed communication and use the same analysis to obtain convergence guarantees.

{% include project-figure.html
  src="/assets/images/delay_example.png"
  alt="Directed graph with delays"
  width="300"
  href="https://arxiv.org/abs/2405.19513"
  title="Tomàs Ortega, delay example"
  caption="An example of a directed graph with delays. The imaginary nodes (dashed) model communication delays."
%}

## Asynchronous federated learning meets compression

In 2021, Meta announced [FedBuff](https://ai.meta.com/research/publications/federated-learning-with-buffered-asynchronous-aggregation/), a system for asynchronous federated learning with buffered aggregation.
In plain terms, the server waits for a certain number of client updates and then averages the updates in the buffer.

Its analysis did not consider communication compression, a key component of practical federated learning systems.
We proposed [an algorithm](https://github.com/TomasOrtega/FLSim) with a similar buffered asynchronous structure and a *hidden-state* feedback mechanism that supports highly aggressive communication compression.

We proved that the algorithm behaves nicely with respect to the compression parameter: the *asynchrony and compression error cross-terms are negligible* in the convergence rate.

Our analysis also revealed and fixed a bug in the original FedBuff convergence proof, without requiring its bounded-gradient assumption.
Independently, [Mohammad Taha Toghani and César A. Uribe](https://arxiv.org/abs/2210.01161) proposed another fix, though without considering compression.

{% include project-figure.html
  src="/assets/images/logistic-regression.png"
  alt="Logistic regression experiment plot with our proposed algorithm"
  width="400"
  href="https://github.com/TomasOrtega/FLSim/blob/main/logistic_regression/results/logistic_regression.png"
  title="Tomàs Ortega, logistic regression with QAFeL"
  caption="Logistic regression with our proposed algorithm. As in the synchronous regime, more local steps mean faster convergence to a more suboptimal point."
%}

## Proving stuff with Lean

On the side, I enjoy theorem proving with Lean and would like to formalize more of my proofs with it.
I used to organize a group for people in the greater Los Angeles area to learn how to write mathematical proofs in Lean.
I have contributed to [Compfiles](https://github.com/dwrensha/compfiles/pull/65), [Sphere-Packing](https://github.com/thefundamentaltheor3m/Sphere-Packing-Lean/pull/134), and [OrderedSemigroups](https://github.com/ericluap/OrderedSemigroups), among other projects.

{% include project-figure.html
  src="/assets/images/lean-logo.svg"
  alt="Lean logo"
  width="250"
  href="https://commons.wikimedia.org/wiki/File:Lean_logo2.svg"
  title="Lean, public domain, via Wikimedia Commons"
  credit="Lean, public domain, via Wikimedia Commons"
%}

## Error-correcting codes from generalized quadrangles

Together with Simeon Ball, we developed [a method](https://arxiv.org/pdf/2405.20524) to construct point-line incidence matrices for several families of generalized quadrangles in polynomial time.
The running times have degrees 4, 6, and 11 depending on the family—high, but still an improvement over existing exponential methods.

Using these constructions, we built what is, to our knowledge, [the largest repository of point-line incidence matrices for generalized quadrangles](https://github.com/TomasOrtega/QuasiCyclicGQs).
The matrices are also quasi-cyclic, a desirable property when constructing error-correcting codes from generalized quadrangles.
The repository includes matrices in the [.alist format](https://www.inference.org.uk/mackay/codes/alist.html) for running LDPC simulations.

{% include project-figure.html
  src="/assets/images/gq-2-2.svg"
  alt="GQ(2,2)"
  width="220"
  href="https://commons.wikimedia.org/wiki/File:GQ(2,2).svg"
  title="Wcherowi, CC BY-SA 4.0, via Wikimedia Commons"
  caption="Visualization of GQ(2,2)."
  credit="Wcherowi, via Wikimedia Commons"
  license="CC BY-SA 4.0"
  license_url="https://creativecommons.org/licenses/by-sa/4.0/"
%}

## Maintaining communication while entering the Martian atmosphere

During the Entry, Descent, and Landing phase of rover missions to Mars, communication is lost because of the large Doppler shift caused by the spacecraft's rapid deceleration in the Martian atmosphere.
During my time at JPL, we proposed [a system](https://ieeexplore.ieee.org/document/9438418) that tracks this Doppler shift to maintain communications throughout the phase.

This system will be implemented in the next generation of NASA's spacecraft radios.

As part of this work, we also derived an analytical approximation for the frequency-error standard deviation of phase-locked loops, which is of independent interest.

{% include project-figure.html
  src="/assets/images/mars-edl.jpg"
  alt="Mars Entry, Descent, and Landing visualization"
  width="480"
  href="https://commons.wikimedia.org/wiki/File:675608main_edl20120809-full.jpg"
  title="NASA/JPL-Caltech, public domain, via Wikimedia Commons"
  caption="Mars Entry, Descent, and Landing. Our system helps most during peak deceleration."
  credit="NASA/JPL-Caltech, public domain, via Wikimedia Commons"
%}

## Just for fun

I also built a [Snake game](https://github.com/TomasOrtega/JavaSnake) in Java.

If you're an NBA nerd, check out [Hardwood Heuristics](https://tomasortega.github.io/Hardwood-Heuristics/), where I look at whether common basketball tropes are backed by data.
