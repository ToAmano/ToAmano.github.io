


### 4ph scattering
https://sites.google.com/site/tianlifengthermal/research/examples


### Scattering Phase Space

When *KPMODE* = 2 and ``SPS = 1``, the three-phonon scattering phase space :math:`P_{3}` is calculated and saved to the file ``PREFIX``.sps. :math:`P_{3}` is defined as

.. math::
    
    P_{3}(\boldsymbol{q}j) = \frac{1}{3m^{3}} (2P_{3}^{(+)}(\boldsymbol{q}j) + P_{3}^{(-)}(\boldsymbol{q}j)),

where :math:`m` is the number of phonon branches and 

.. math::
    
    P_{3}^{(\pm)}(\boldsymbol{q}j) = \frac{1}{N_{q}}\sum_{\boldsymbol{q}_{1},\boldsymbol{q}_{2}, j_{1}, j_{2}}\delta(\omega_{\boldsymbol{q}j}\pm\omega_{\boldsymbol{q}_{1}j_{1}}-\omega_{\boldsymbol{q}_{2}j_{2}})\delta_{\boldsymbol{q}\pm\boldsymbol{q}_{1},\boldsymbol{q}_{2}+\boldsymbol{G}}.

*anphon* also print the total scattering phase space

.. math::

    P_{3} = \frac{1}{N_{q}}\sum_{\boldsymbol{q}j} P_{3}(\boldsymbol{q}j).

When ``SPS = 2``, the three-phonon scattering phase space with the occupation factor :math:`W_{3}^{(\pm)}` will be calculated and saved to the file ``PREFIX``.sps_Bose. :math:`W_{3}^{(\pm)}` is defined as

.. math::

    W_{3}^{(\pm)}(\boldsymbol{q}j) = \frac{1}{N_{q}}{\sum_{\boldsymbol{q}_{1},\boldsymbol{q}_{2}, j_{1}, j_{2}}}
    \left\{
      \begin{array}{c}
      n_{2} - n_{1} \\
      n_{1} + n_{2} + 1
      \end{array}
    \right\}
    \delta(\omega_{\boldsymbol{q}j}\pm\omega_{\boldsymbol{q}_{1}j_{1}}-\omega_{\boldsymbol{q}_{2}j_{2}})\delta_{\boldsymbol{q}\pm\boldsymbol{q}_{1},\boldsymbol{q}_{2}+\boldsymbol{G}}.

Here, :math:`n_{1}=n(\omega_{\boldsymbol{q}_{1}j_{1}})` and :math:`n_{2}=n(\omega_{\boldsymbol{q}_{2}j_{2}})` where :math:`n(\omega) = \frac{1}{e^{\hbar\omega/k_B T}-1}` is the Bose-Einstein distribution function. Since :math:`n(\omega)` is temperature dependent, :math:`W_{3}^{(\pm)}` is also temperature dependent. The file ``PREFIX``.sps_Bose contains :math:`W_{3}^{(\pm)}` for all phonon modes at various temperatures specified with ``TMIN``, ``TMAX``, and ``DT`` tags.

