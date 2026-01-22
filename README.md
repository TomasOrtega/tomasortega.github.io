<div align="center">
  <img src="https://github.com/TomasOrtega.png" width="180px" height="180px" id="profile-pic" alt="Tomas Ortega" style="border-radius: 50%; object-fit: cover; border: 3px solid #eee;"/>
  
  <h1>Tomàs Ortega</h1>
  
  <p>
    <b>PhD Candidate</b><br>
    Electrical Engineering and Computer Science<br>
    University of California, Irvine
  </p>

  <p>
    <a href="https://scholar.google.com/citations?user=YElSNAIAAAAJ&hl=en">
      <img src="https://img.shields.io/badge/Google%20Scholar-4285F4?style=for-the-badge&logo=google-scholar&logoColor=white" alt="Google Scholar"/>
    </a>
    <a href="https://github.com/TomasOrtega">
      <img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white" alt="GitHub"/>
    </a>
    <a href="https://bsky.app/profile/tomasortega.net">
      <img src="https://img.shields.io/badge/Bluesky-0285FF?style=for-the-badge&logo=bluesky&logoColor=white" alt="Bluesky"/>
    </a>
    <a href="https://twitter.com/tomas__ortega">
      <img src="https://img.shields.io/badge/X-%23000000.svg?style=for-the-badge&logo=X&logoColor=white" alt="Twitter"/>
    </a>
    <a href="https://www.linkedin.com/in/tomas-ortega-sc/">
      <img src="https://img.shields.io/badge/linkedin-%230077B5.svg?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn"/>
    </a>
  </p>

  <a href="https://tomasortega.github.io/CV.pdf" class="btn-cv">Check out my CV!</a>
  
  <br><br>
</div>

<a rel="me" href="https://mathstodon.xyz/@tomasortega">Mastodon</a>
		<meta http-equiv="refresh" content="0; url=https://www.tomasortega.net/"> 

Originally, I am from Sant Cugat (near Barcelona) but I've lived in Madison, Pasadena, Irvine, and now in Philadelphia.

My doctoral advisor is [Hamid Jafarkhani](https://www.ece.uci.edu/~hamidj/), and I have previously been at NASA's JPL with [Marc Sanchez-Net](https://scholar.google.com/citations?user=0C0EdK8AAAAJ&hl=en), at the Vector Institute with [Xiaoxiao Li](https://xxlya.github.io/), and at Nokia Bell Labs (Murray Hill) with [Sahil Tikale](https://www.nokia.com/people/sahil-tikale/). 

Before joining UCI, I graduated from Universitat Politècnica de Catalunya with a double degree in Mathematics and Electrical Engineering as part of the [CFIS program](https://cfis.upc.edu/en), and a MS in [Advanced Mathematics and Mathematical Engineering](https://mamme.masters.upc.edu/en), focused on discrete mathematics and information theory.

For my undergrad thesis I worked with the Communications Architectures and Research Section at [NASA's Jet Propulsion Laboratory](https://www.jpl.nasa.gov/), helping build the next-generation space radios.

# Research interests

My research is focused on making distributed algorithms work in communication-constrained networks, with an emphasis on privacy-preserving Machine Learning. I derive theoretical bounds and demonstrate my results with practical implementations. This includes algorithms for Federated Learning and Decentralized Control.

More broadly, I am interested in optimization, information theory and AI.

# Some highlighted projects

### Privacy-preserving Error Feedback for Distributed Learning

Practical distributed learning often uses biased aggressive compression for communication from the clients to the server. However, to guarantee convergence, we need client-specific control variates to perform error feedback. 

Individual control variates kill privacy guarantees, and do not scale with the number of clients. To fix error feedback, we proposed [a framework](https://arxiv.org/abs/2412.04538) that leverages previous *aggregated* client updates for feedback. This allows highly aggressive compression without the privacy and scale issues that come with client-specific control variates. The open-source code is available [here](https://github.com/TomasOrtega/TellMeTwice).

### Truly decentralized learning on directed graphs

Decentralized optimization algorithms typically require communication between nodes to be bi-directional. 

In the directed case, existing algorithms required nodes to know how many listeners they have (knowledge of their out-degree). We proposed a [series of works](https://github.com/TomasOrtega/DT-GO) that circumvent this requirement.

A nice property of this framework is that it naturally accomodates networks with delays, as one can add imaginary nodes to the network to model delays, and use the same analysis to obtain convergence guarantees.

Currently, I'm interested in incorporating more aspects of real networks to bridge the gap between the practice and theory of decentralized learning.

### Proving stuff with Lean

On the side, I enjoy theorem proving with Lean. In the future I would like to formalize more of my proofs using Lean. 
I used to organize a group for people in the greater LA area to learn how to write mathematical proofs in Lean.
I have contributed to [Compfiles](https://github.com/dwrensha/compfiles/pull/65), [Sphere-Packing](https://github.com/thefundamentaltheor3m/Sphere-Packing-Lean/pull/134), and [OrderedSemigroups](https://github.com/ericluap/OrderedSemigroups), among others. 


### Error correcting codes from Generalized Quadrangles

Together with Simeon Ball, we developed [a method](https://arxiv.org/pdf/2405.20524) to construct point-line incidence matrices for Generalized Quadrangles in polynomial time (polynomial to the 4th, 6th and 11th power for different GQs but hey, still better than existing exponential methods). 

This allowed us to construct [the largest point-line GQ incidence matrix repository](https://github.com/TomasOrtega/QuasiCyclicGQs) that currently exists. 
But, better than that, these point-line incidence matrices are quasi-cyclic! 
This is a really desireable property if you want to construct error correcting codes from GQs, which achieve a very good error rate to round of belief propagation decoding ratio. 
The repository also has [.alist](https://www.inference.org.uk/mackay/codes/alist.html) matrices to easily run LDPC simulations.

### Maintaining communication while entering the Martian atmosphere 

During the Entry, Descent and Landing (EDL) phase of rover missions to Mars, the communications are lost due to the large Doppler shift caused by the spacecraft dramatically decelerating when hitting the Martian atmosphere.
During my time at JPL, we proposed [a system](https://ieeexplore.ieee.org/document/9438418) to enable us to track this shift in Doppler and maintain comms throughout. 

This system will be implemented in the next generation of NASA's spacecraft radios.

As a part of this line of work, we derived an analytical approximation for Phase-Locked Loops frequency error standard deviation, which is of independent interest.

### If you made it this far...
Here is a [Snake game](https://github.com/TomasOrtega/JavaSnake) I coded in Java.
